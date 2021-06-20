//
//  FetchLoginUserInfo.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/17.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FetchLoginUserInfo: ObservableObject {
    @Published var usermodel = UserModel(dic: ["email": "default"])
    
    init() {
        fetchloginUserInfo()
    }
    
    func fetchloginUserInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid)
            .getDocument { (snapshot, error) in
                if let error = error {
                    print("Failed getting user data: \(error)")
                    return
                }
                guard let snapshot = snapshot else { return }
                guard let data = snapshot.data() else { return }
                print("\(data)")
                let user = UserModel(dic: data)
                self.usermodel = user
            }
    }
}
