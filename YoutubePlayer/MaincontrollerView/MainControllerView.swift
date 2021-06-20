//
//  MainControllerView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/16.
//

import SwiftUI

struct MainControllerView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            PostRowView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Post")
                }
            UserListView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Users")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Prodfile")
                }
        }
    }
}

struct MainControllerView_Previews: PreviewProvider {
    static var previews: some View {
        MainControllerView()
    }
}
