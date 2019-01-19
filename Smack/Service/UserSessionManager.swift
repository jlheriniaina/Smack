//
//  UserSessionManager.swift
//  Smack
//
//  Created by lucas on 15/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import Foundation

class UserSessionManager {
    private var KEY_USER_EMAIL = "email"
    private var KEY_USER_LOGIN = "loginIn"
    private var KEY_USER_TOKEN = "token"
    private var KEY_AVATAR_IMAGE = "avatar"
    private var userDefault = UserDefaults.standard
    private var KEY_USER = "user"
    
    static var instance = UserSessionManager()
    
    func getToken() -> String {
        
        return userDefault.value(forKey: KEY_USER_TOKEN) as! String
    }
    
    func getIslogin() -> Bool {
        
        return userDefault.bool(forKey: KEY_USER_LOGIN)
    }
    
    func getEmail() -> String {
        return userDefault.value(forKey: KEY_USER_EMAIL) as! String
    }
    func setIsLogin(isLogin: Bool) {
        userDefault.set(isLogin, forKey: KEY_USER_LOGIN)
    }
    func setEmail(email: String) {
        userDefault.set(email, forKey: KEY_USER_EMAIL)
    }
    func setToken(token: String) {
        userDefault.set(token, forKey: KEY_USER_TOKEN)
    }
    func setAvatar(avatar: String) {
        userDefault.set(avatar, forKey: KEY_AVATAR_IMAGE)
    }
    func getAvatar() -> String? {
        return userDefault.value(forKey: KEY_AVATAR_IMAGE) as? String
    }
    func isLoginUser(data : [String: AnyObject]){
        userDefault.set(data, forKey: KEY_USER)
    }
    func getIsLoginUser() ->  [String: AnyObject] {
        return userDefault.value(forKey: KEY_USER) as! [String: AnyObject]
    }
    func logout() {
        userDefault.removeObject(forKey: KEY_USER)
        userDefault.removeObject(forKey: KEY_AVATAR_IMAGE)
        userDefault.removeObject(forKey: KEY_USER_EMAIL)
        userDefault.removeObject(forKey: KEY_USER_TOKEN)
        setIsLogin(isLogin: false)
    }
}
