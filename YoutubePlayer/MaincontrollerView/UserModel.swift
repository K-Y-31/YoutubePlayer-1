//
//  UserModel.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/16.
//

import Foundation
import FirebaseFirestore

struct UserModel {
    let email: String
    let username: String
    let createdAt: Timestamp
    let profileImageUrl: String
    
    var uid: String?
    var friends: [String]?
    var Message: String?
    var favoritevideo: [String]?
    var Role: String?
    
    
    init(dic: [String: Any]) {
        self.email = dic["email"] as? String ?? ""
        self.username = dic["username"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
        self.profileImageUrl = dic["profileImageUrl"] as? String ?? ""
        self.Message = dic["Message"] as? String ?? ""
        self.Role = dic["Role"] as? String ?? ""
        self.friends = dic["friends"] as? [String] ?? [""]
    }
}
