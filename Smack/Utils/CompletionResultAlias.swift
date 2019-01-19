//
//  CompletionResultAlias.swift
//  Smack
//
//  Created by lucas on 19/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import Foundation


typealias CompletTask = ( _ Success: Bool) -> ()
typealias CompletionHandeler = (_ Succes: Bool , _ data: [Channel] ) ->()
typealias CompletionResult = (_ Succes: Bool , _ channel: Channel ) ->()
typealias CompletionMessage = (_ Succes: Bool, _ message: [Message]) ->()
