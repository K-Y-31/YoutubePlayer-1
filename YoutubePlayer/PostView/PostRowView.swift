//
//  PostRowView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/15.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct PostRowView: View {
    @ObservedObject var fetchusersinfo = FetchUserModelinFireStore()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.fetchusersinfo.usermodellist, id: \.email) { item in
                            URLImageView(viewModel: .init(url: item.profileImageUrl))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        }
                    }
                }
                ScrollView(showsIndicators: false) {
                    ForEach(1..<10) { item in
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                URLImageView(viewModel: .init(url: "https://i.ytimg.com/vi/ilqQJrbXghQ/mqdefault.jpg"))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                Text("BTS")
                                    .font(.subheadline)
                            }
                            URLImageView(viewModel: .init(url: "https://i.ytimg.com/vi/-idCOExhTT4/mqdefault.jpg"))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: 250)
                        }
                    }
                }
            }.navigationBarTitle(Text("Post"))
        }
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView()
    }
}
