//
//  MessageService.swift
//  Smack
//
//  Created by lucas on 18/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import Foundation
import Alamofire

class MessageService {
    public static let instance = MessageService()
    public var channels = [Channel]()
    public var channel: Channel!
    
    func allChannel(completion: @escaping CompletionHandeler) {
        let header = ["Authorization":"Bearer \(UserSessionManager.instance.getToken())",
            "Content-Type": "application/json; chaset=utf8"]
        
        Alamofire.request(URL_GET_CHANNEL,method: .get, parameters: nil,
                          encoding: JSONEncoding.default, headers: header).responseJSON { (responses) in
            if responses.result.error == nil {
                guard let data = responses.data else { return }
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                    if !self.channels.isEmpty {
                        completion(true,self.channels)
                        NotificationCenter.default.post(name: NOTIF_LOAD_CHANNEL, object: nil)
                  }
                }catch let error {
                     print(error.localizedDescription)
                }
            }else {
                if responses.error != nil {
                     print(responses.error!.localizedDescription)
                    completion(false,self.channels)
                }
               
            }
        }
    }
    func clearChannel() {
        channels.removeAll()
    }
    
}
