//
//  SearchUserView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/16.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth


struct UserListView: View {
    @ObservedObject var chatroom = FetchChatRoomsInfo()
    @State var changeview: Bool = false
    
    var body: some View {
        NavigationView {
            UserListSubView(chatroom: chatroom)
                .navigationBarTitle(Text("ChatRoom"))
//                .navigationBarItems(
//                    trailing:
//                        Button(action: {
//                            self.changeview.toggle()
//                        }) {
//                            VStack {
//                                Image(systemName: "person.fill")
//                                Text("フレンドを探す")
//                            }
//                        }
//                )}.fullScreenCover(isPresented: self.$changeview, content: {
//                    SearchUserListView()
//                })
        }
    }
}
    



struct UserListSubView: View {
    @ObservedObject var chatroom: FetchChatRoomsInfo
    init(chatroom: FetchChatRoomsInfo) {
        self.chatroom = chatroom
    }
    var body: some View {
        List(self.chatroom.chatroomlist, id: \.members) { item in
            HStack {
                URLImageView(viewModel: .init(url: item.partonerUser!.profileImageUrl))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                Text(item.partonerUser!.username)
                    .font(.headline)
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
