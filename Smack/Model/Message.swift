//
//  Message.swift
//  Smack
//
//  Created by lucas on 19/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import Foundation

class Message: Decodable {
    private var _id: String!
    private var messageBody: String!
    private var userId: String!
    private var channelId: String!
    private var userName: String!
    private var userAvatar: String!
    private var userAvatarColor: String!
    private var timeStamp: String!
    
    init(content: String, idUser: String, idChannel: String,
         name: String, avatar: String, color: String) {
        self.messageBody = content
        self.userId = idUser
        self.channelId = idChannel
        self.userName = name
        self.userAvatar = avatar
        self.userAvatarColor = color
    }
    
    init(id: String, content: String, idUser: String, idChannel: String,
         name: String, avatar: String, color: String, time: String) {
        self._id = id
        self.messageBody = content
        self.userId = idUser
        self.channelId = idChannel
        self.userName = name
        self.userAvatar = avatar
        self.userAvatarColor = color
        self.timeStamp = time
    }
    func getId() -> String {
        return _id
    }
    func getContent() -> String {
        return messageBody
    }
    func getUserId() -> String {
        return userId
    }
    func getChannelId() -> String {
        return channelId
    }
    func getUsername() -> String {
        return userName
    }
    func getUserAvatar() -> String {
        return userAvatar
    }
    func getUserColorAvatar() -> String {
        return userAvatarColor
    }
    func getTimeStamp() -> String {
        return timeStamp
    }
}
