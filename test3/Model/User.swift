//
//  User.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/06.
//
import Foundation
import Firebase

class User {
    
    let email: String
    let username: String
    let createdAt: Timestamp
    let profileImageUrl: String
    var uid: String?
    
    init(dic: [String: Any]) {
        
        self.email = dic["email"] as? String ?? ""
        self.profileImageUrl =  dic["profileImageUrl"] as? String ?? ""
        self.createdAt =  dic["createdAt"] as? Timestamp ?? Timestamp()
        self.username  =  dic["username"] as? String ?? ""
        
    }
    
    
}

