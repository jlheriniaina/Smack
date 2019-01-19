//
//  Constants.swift
//  Smack
//
//  Created by lucas on 13/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import Foundation

typealias CompletTask = ( _ Success: Bool) -> ()
typealias CompletionHandeler = (_ Succes: Bool , _ data: [Channel] ) -> ()
typealias CompletionResult = (_ Sucess: Bool , _ channel: Channel ) -> ()

let LOGIN_VC = "toLogin"
let CREATE_ACCOUNT = "toCreateAccount"
let BASE_URL = "https://chatyapismack.herokuapp.com/v1/"
//let BASE_URL = "http://localhost:3005/v1"

let URL_REGISTER = "\(BASE_URL)/account/register"
let URL_LOGIN = "\(BASE_URL)/account/login"
let URL_ADD_USER = "\(BASE_URL)/user/add"
let URL_GET_USER_EMAIL = "\(BASE_URL)/user/byEmail/"
let URL_GET_CHANNEL = "\(BASE_URL)/channel"

let NOTIF_DATA_USER = Notification.Name("notifUserDataChange")
let NOTIF_LOAD_CHANNEL = Notification.Name("loadChannels")
let NOTIF_LOAD_SELECTED = Notification.Name("channelSelected")






