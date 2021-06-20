//
//  FetchUserModelinFireStore.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/17.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class FetchUserModelinFireStore: ObservableObject {
    @Published var usermodellist: [UserModel] = [UserModel]()
    
    init() {
        fetchuserModelinFireStore()
    }
    
    private func fetchuserModelinFireStore() {
        Firestore.firestore().collection("users").getDocuments { (snapshots, error) in
            if let error = error {
                print("Failed getting user info to FireStore: \(error)")
                return
            }
            snapshots?.documents.forEach({ (snapshot) in
                let data = snapshot.data()
                var user = UserModel(dic: data)
                user.uid = snapshot.documentID
                guard let uid = Auth.auth().currentUser?.uid else { return }
                if (uid == snapshot.documentID) {
                    return
                }
                Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
                    if let error = error {
                        print("Failed getting snapshot: \(error)")
                        return
                    }
                    let frienddata = snapshot?.data()
                    let frienduser = UserModel(dic: frienddata!)
                    print(frienduser.uid, snapshot?.documentID)
                    if (frienduser.uid == snapshot?.documentID) {
                        print(frienduser.uid, snapshot?.documentID)
                        return
                    }
                    else {
                        self.usermodellist.append(user)
                    }
                }
            })
        }
    }
}
