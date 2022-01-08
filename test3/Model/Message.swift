//
//  Message.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/06.
//

import Foundation
import Firebase
import UIKit

class Message {
    
    let name: String
    let message: String
    let uid: String
    let createAt: Timestamp
    
    var partnerUser: User?
    
    init(dic: [String: Any]) {
        
        self.name = dic["name"] as? String ?? ""
        self.message = dic["message"] as? String ?? ""
        self.uid = dic["uid"] as? String ?? ""
        self.createAt = dic["createAt"] as? Timestamp ?? Timestamp()
        var chatlist:Array = ["おな禁の極意", "雑談部屋", "モテ男への道"]
    }
}

