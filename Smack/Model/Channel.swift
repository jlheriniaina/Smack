//
//  Channel.swift
//  Smack
//
//  Created by lucas on 18/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import Foundation

class Channel : Decodable {
    private var _id: String!
    private var name: String!
    private var description: String!
    
    init(id: String, name: String, desc: String) {
        self._id = id
        self.name = name
        self.description = desc
    }
    func getId() -> String {
        return _id
    }
    func getName() -> String {
        return name
    }
    func getDesc() -> String {
        return description
    }
}
