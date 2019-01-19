//
//  SocketService.swift
//  Smack
//
//  Created by lucas on 19/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import Foundation
import SocketIO

class SocketService: NSObject {
    public static let instance = SocketService()
    public let manager = SocketManager(socketURL: URL(string: BASE_URL)!)
    public var socket: SocketIOClient!
    private var channels = [Channel]()
    
    override init() {
        super.init()
        self.socket = manager.defaultSocket
    }
  
    func establishConnection() {
        socket.connect()
    }
    func closeConnection() {
        socket.on("disconnect") {data, ack in
            print("socket disconnected")
        }
        socket.disconnect()
    }
    func createChannel(name: String, desc: String, completion: @escaping CompletTask) {
        socket.emit("newChannel", name, desc)
        completion(true)
    }
    func getChannel(completion: @escaping CompletionResult) {
        socket.on("channelCreated") { (data, emiteur) in
            guard let name = data[0] as? String else { return }
            guard let desc = data[1] as? String else { return }
            guard let id = data[2] as? String else { return }
            print(name+" "+desc+" "+id)
            let channel = Channel(id: id, name: name, desc: desc)
            completion(true,channel)
        }
    }
    func sendMesage(message: Message, completion: @escaping CompletTask) {
       socket.emit("newMessage", message.getContent(), message.getUserId(), message.getChannelId(),
                   message.getUsername(), message.getUserAvatar(), message.getUserColorAvatar())
        completion(true)
    }
    func getMessage(completion: @escaping CompletTask) {
        socket.on("messageCreated") { (data, emiteur) in
            guard let messageBody = data[0] as? String else { return }
            guard let userId = data[1] as? String else { return }
            guard let channelId = data[2] as? String else { return }
            guard let userName = data[3] as? String else { return }
            guard let userAvatar = data[4] as? String else { return }
            guard let userAvatarColor = data[5] as? String else { return }
            guard let id = data[6] as? String else { return }
            guard let timeStamp = data[7] as? String else { return }
            if channelId == MessageService.instance.channel.getId() && UserSessionManager.instance.getIslogin() {
                let newMessage = Message(id: id, content: messageBody, idUser: userId, idChannel: channelId, name: userName, avatar: userAvatar, color: userAvatarColor, time: timeStamp)
                MessageService.instance.messages.append(newMessage)
                 completion(true)
            }else {
                completion(false)
            }
           
        }
    }
    func doListenTapingMessage(_ completionHandeler: @escaping (_ doListenTapingUser: [String: String]) -> Void) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHandeler(typingUsers)
        }
    }
    
}
