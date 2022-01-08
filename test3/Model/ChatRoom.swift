//
//  ChatRoom.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/06.
//

import Foundation
import Firebase


class ChatRoom {
    
    
    let latestMessageId: String
    let members: [String]
    let createAt: Timestamp
    
    var latestMessage: Message?
    
    var partnerUser: User?
    
    var documentId: String?
    
   
    
    init(dic: [String: Any]) {
        
        
        self.latestMessageId = dic["latestMessageId"] as? String ?? ""
        self.members = dic["members"] as? [String] ?? [String]()
        self.createAt = dic["createdAt"] as? Timestamp ?? Timestamp()
      
    }
}

