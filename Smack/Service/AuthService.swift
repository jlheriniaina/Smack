//
//  AuthService.swift
//  Smack
//
//  Created by lucas on 13/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import Foundation
import Alamofire


 class AuthService {
    
    static let authService = AuthService()
    let userDefault = UserDefaults.standard
    
    func getIsLoggin() -> Bool {
        return userDefault.bool(forKey: LOGGED_IN_KEY)
    }
    func setIsLoggin(loginKey: Bool){
        userDefault.set(loginKey, forKey: LOGGED_IN_KEY)
    }
    func getAuthToken() -> String {
        
      return userDefault.value(forKey: TOKEN_KEY) as! String
    }
    func setAuthToken(token: String){
      userDefault.set(token, forKey: TOKEN_KEY)
    }
    func getUserEmail() -> String {
        return userDefault.value(forKey: USER_EMAIL) as! String
    }
    func setUserEmail(email: String) {
        userDefault.set(email, forKey: USER_EMAIL)
    }
    func registerUser(email: String, password: String, competion: @escaping taskComplet) {
        let header = ["Content-Type": "application/json; chaset=utf8"]
        let requestParams : [String : Any] = ["email": email.lowercased(), "password": password]
      
        Alamofire.request(URL_REGISTER,method: .post, parameters: requestParams,
                  encoding: JSONEncoding.default, headers: header).responseString { (responses) in
                    if responses.result.error != nil {
                        competion(true)
                    }else {
                        competion(false)
                        debugPrint(responses.result.error as? Any)
                    }
                    
        
        }
        
        
    }
}
