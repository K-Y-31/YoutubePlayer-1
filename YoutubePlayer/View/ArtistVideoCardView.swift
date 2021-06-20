//
//  ArtistVideoCardView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/11.
//

import SwiftUI

struct ArtistVideoCardView: View {
    @State var video_info: FavoriteArtistItems
    var body: some View {
        VStack {
            URLImageView(viewModel: .init(url: video_info.snippet.thumbnails.medium!.url))
                .aspectRatio(contentMode: .fill)
                .frame(width: 246, height: 150, alignment: .center)
                .cornerRadius(15)
                .shadow(radius: 10)
            Text(video_info.snippet.title)
                .font(.title2)
                .lineLimit(2)
                .shadow(radius: 5)
        }
    }
}

struct ArtistTitleOverlay: View {
    var title: String
    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0)]), startPoint: .bottom, endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle().fill(gradient)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .bold()
            }.padding()
        }.foregroundColor(.white)
    }
}

