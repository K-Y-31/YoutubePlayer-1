//
//  ChatRoom.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/17.
//

import Foundation
import FirebaseFirestore

struct ChatRoom {
    let latestMesageID: String
    let members: [String]
    let createdAt: Timestamp
    
    var partonerUser: UserModel?
    
    init(dic: [String: Any]) {
        self.latestMesageID = dic["latestMesageID"] as? String ?? ""
        self.members = dic["members"] as? [String] ?? [""]
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
}
