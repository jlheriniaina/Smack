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
    
}
