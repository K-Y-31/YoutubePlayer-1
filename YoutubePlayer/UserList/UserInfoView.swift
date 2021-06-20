//
//  UserInfoView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/17.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct UserInfoView: View {
    @State var userinfo: UserModel!
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            VStack {
                URLImageView(viewModel: .init(url: userinfo.profileImageUrl))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
                    .clipShape(Circle())
                    .padding()
                Text(userinfo.username)
                    .font(.title3)
                    .padding()
                HStack(spacing: UIScreen.main.bounds.width/2 - 50) {
                    Button(action: {
                        self.addUserFunc(selectuser: userinfo)
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Text("追加")
                    }.padding()
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Text("キャンセル")
                    }
                }
            }
        }
    }
    
    private func addUserFunc(selectuser: UserModel) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let partoneruser = selectuser.uid else { return }
        let members = [uid, partoneruser]
        
        let docdata: [String: Any] = [
            "members": members,
            "latestMesageID": "",
            "createdAt": Timestamp()
        ]
        
        Firestore.firestore().collection("chatRooms").addDocument(data:docdata ) { (error) in
            if let error = error {
                print("Failed saving chatrooms infomation :\(error)")
                return
            }
            print("Suceess saving chatrooms info")
            Firestore.firestore().collection("users").document(uid).updateData(["friends": FieldValue.arrayUnion([selectuser.uid! as String])]) { err in
                if err != nil {
                    print("Error updating document: \(String(describing: err))")
                }
                else {
                    print("Document successfully update")
                }
            }
        }
        
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
