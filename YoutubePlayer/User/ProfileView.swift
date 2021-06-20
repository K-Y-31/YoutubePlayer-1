//
//  ProfileView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/18.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @ObservedObject var fetchuserinfo = FetchLoginUserInfo()
    @State var ispresented : Bool = false
    @State var issetting: Bool = false
    @State var usermodel = UserModel(dic: ["email": "default"])
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Text("Profile")
                    .font(.title)
                Spacer(minLength: 0)
                Button(action: {
                    self.ispresented.toggle()
                }) {
                    Text("Friendを探す")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .background(Color(.blue))
                        .cornerRadius(10)
                }.padding()
                Button(action: {
                    self.issetting.toggle()
                }) {
                    Image(systemName: "gearshape.fill")
                }
            }
            .padding()
            HStack {
                VStack(alignment: .leading) {
                    URLImageView(viewModel: .init(url: fetchuserinfo.usermodel.profileImageUrl))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 8, y: 8)
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text(fetchuserinfo.usermodel.username)
                        .font(.title)
                        .foregroundColor(Color.black.opacity(0.8))
                    Text(fetchuserinfo.usermodel.Role ?? "")
                        .foregroundColor(Color.black.opacity(0.7))
                        .padding(.top, 8)
                    Text(fetchuserinfo.usermodel.Message ?? "")
                        .font(.title)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                .padding(.leading, 20)
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            Spacer(minLength: 0)
        }
        .background(Color("Color1").edgesIgnoringSafeArea(.all))
        .fullScreenCover(isPresented: self.$ispresented, content: {
            SearchUserListView()
        })
        .fullScreenCover(isPresented: self.$issetting, content: {
            SettingView()
        })
//        .onWillAppear {
//            self.fetchuserinfo.fetchloginUserInfo()
//        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
