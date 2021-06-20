//
//  SearchUserListView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/17.
//

import SwiftUI
import FirebaseFirestore
import Firebase
import FirebaseAuth

struct SearchUserListView: View {
    @ObservedObject var fetchusers = FetchUserModelinFireStore()
    @Environment(\.presentationMode) var presentation
    @State var ispresented: Bool = false
    var body: some View {
        NavigationView {
            List(fetchusers.usermodellist, id: \.email) { item in
                HStack {
                    Button(action: {
                        self.ispresented.toggle()
                    }) {
                        URLImageView(viewModel: .init(url: item.profileImageUrl))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text(item.username)
                            .font(.headline)
                    }
                }.fullScreenCover(isPresented: self.$ispresented, content: {
                    UserInfoView(userinfo: item)
                })
            }.navigationBarItems(
                trailing:
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }) {
                        Text("Back")
                    }
            )
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
        }
    }
}

struct SearchUserListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserListView()
    }
}
