//
//  FetchChatRoomsInfo.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/17.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Combine

class FetchChatRoomsInfo: ObservableObject {
    @Published var chatroomlist: [ChatRoom] = [ChatRoom]()
    
    private(set) var objectWillChange: ObservableObjectPublisher = ObjectWillChangePublisher()
    
    init() {
        fetchchatroomsFromFireBase()
    }
    
    func fetchchatroomsFromFireBase() {
        Firestore.firestore().collection("chatRooms").getDocuments { (snapshots, error) in
            if let error = error {
                print("Failed getting chatrooms info: \(error)")
                return
            }
            
            snapshots?.documentChanges.forEach({ (documentChange) in
                switch documentChange.type {
                case .added:
                 
                    let data = documentChange.document.data()
                    var chatroom = ChatRoom(dic: data)
                    
                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    chatroom.members.forEach { (memberuid) in
                        if memberuid != uid {
                            Firestore.firestore().collection("users").document(memberuid).getDocument { (snapshot, error) in
                                if let error = error {
                                    print("Failed getting user info: \(error)")
                                    return
                                }
                                
                                guard let data = snapshot?.data() else { return }
                                var user = UserModel(dic: data)
                                user.uid = documentChange.document.documentID
                                chatroom.partonerUser = user
                                self.chatroomlist.append(chatroom)
                                print("chatrrom count: \(self.chatroomlist.count)")
                            }
                        }
                    }
                  
                    
                case .modified:
                    print("Nothing")
                case .removed:
                    print("Nothing")
                }
            })
        }
    }
    
}
