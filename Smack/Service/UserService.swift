//
//  UserService.swift
//  Smack
//
//  Created by lucas on 15/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class UserService {
    static let instance = UserService()
 
    
    func registerUser(email: String, password: String, competion: @escaping CompletTask) {
        let header = ["Content-Type": "application/json; chaset=utf8"]
        let requestParams : [String : Any] = ["email": email.lowercased(), "password": password]
        Alamofire.request(URL_REGISTER,method: .post, parameters: requestParams,
                          encoding: JSONEncoding.default, headers: header).responseString { (responses) in
                if responses.result.error == nil {
                    competion(true)
                    }else {
                    competion(false)
                    print(responses.result.error)
            }
        }
        
    }
    func loginUser(email: String, password: String, completion: @escaping CompletTask) {
        let header = ["Content-Type": "application/json; chaset=utf8"]
        let requestParams : [String : Any] = ["email": email.lowercased(), "password": password]
        Alamofire.request(URL_LOGIN,method: .post, parameters: requestParams,
                          encoding: JSONEncoding.default, headers: header).responseJSON{ (responses) in
            if responses.result.error == nil {
                guard let data = responses.data else { return }
                    let json = JSON(data)
                    print(json)
                    UserSessionManager.instance.setEmail(email: json["user"].stringValue)
                    UserSessionManager.instance.setToken(token: json["token"].stringValue)
                    UserSessionManager.instance.setIsLogin(isLogin: true)
                
                    completion(true)
                   }else {
                    print(responses.result.error as! String)
                    completion(false)
            }
        }
    }
    func createUser(user: User, completion: @escaping CompletTask) {
        let requestParams = ["name": user.name,
                             "email":user.email.lowercased(),
                             "avatarName": user.avatarName,
                             "avatarColor": user.avatarColor ]
        let header = ["Authorization":"Bearer \(UserSessionManager.instance.getToken())",
                      "Content-Type": "application/json; chaset=utf8"]
        Alamofire.request(URL_ADD_USER,method: .post, parameters: requestParams,
                          encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                if response.result.error == nil {
                    guard let data = response.data else { return }
                    self.data(data: data)
                    completion(true)
                }else {
                    print(response.error.debugDescription)
                    completion(false)
            }
        }
    }
    func getUserByEmail(completion : @escaping CompletTask) {
        let header = ["Authorization":"Bearer \(UserSessionManager.instance.getToken())",
            "Content-Type": "application/json; chaset=utf8"]
    
        Alamofire.request(URL_GET_USER_EMAIL+UserSessionManager.instance.getEmail(),method: .get, parameters: nil,
                          encoding: JSONEncoding.default, headers: header).responseJSON { (responses) in
                    if responses.result.error == nil {
                       
                        guard let data = responses.data else { return}
                        self.data(data: data)
                        completion(true)
                    }else {
                        completion(false)
                }
        }
    }
    func data(data: Data) {
        let users = JSON(data)
        let dict = ["id": users["_id"].stringValue, "name": users["name"].stringValue, "email": users["email"].stringValue,
                    "avatarName": users["avatarName"].stringValue, "avatarColor": users["avatarColor"].stringValue]
        print(dict)
        UserSessionManager.instance.isLoginUser(data: dict as [String : AnyObject])
    }
}
