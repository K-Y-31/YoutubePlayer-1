//
//  HomeView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/06.
//

import SwiftUI

struct HomeView: View {
    @State var isplay: Bool = true
    var body: some View {
        NavigationView {
            ScrollView {
                Divider()
                VideoView(isplay: $isplay)
                Spacer(minLength: 30)
            }.navigationBarTitle(Text("Home"))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
