//
//  User.swift
//  Smack
//
//  Created by lucas on 15/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import Foundation

class User : NSObject, Codable {
    private var _id: String!
    private var _name: String!
    private var _avatarName: String!
    private var _avatarColor: String!
    private var _email: String!
    
    override init() {
        
    }
    var id : String {
        return _id
    }
    var name: String {
        return _name
    }
    var email : String {
        return _email
    }
    var  avatarName: String {
        return _avatarName
    }
    var avatarColor: String {
        return _avatarColor
    }
    func setAvatarName(avatarName: String) {
        _avatarName = avatarName
    }
    init(id: String, name: String, email: String, avatarName: String, avatarColor: String) {
        self._id = id
        self._name = name
        self._email = email
        self._avatarName = avatarName
        self._avatarColor = avatarColor
    }
    init(name: String, email: String, avatarName: String, avatarColor: String) {
        self._name = name
        self._email = email
        self._avatarName = avatarName
        self._avatarColor = avatarColor
     
    }
}
