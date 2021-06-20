//
//  AudioPlayerView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/05.
//

import SwiftUI
import AVKit
import YoutubeKit

struct AudioPlayerView: View {
    @State private var playerSize: CGSize = .zero
    @State var videoid: String
    @State var videotitle: String
    @State var duration: Double = 0.0
    @State var width: CGFloat = 0
    @State var isplay: Bool
    @State var state: Int = 0
    @State var currentTime: Double = 0
    @State var forward15: Bool = false
    @State var goback15: Bool = false
    @State var sample: Double = 0
   
    var body: some View {
        VStack {
//            Button(action: {
//
//            }) {
//                Image(systemName: "tray.and.arrow.down.fill").font(.title)
//            }.position(x: UIScreen.main.bounds.width - 30, y: UIScreen.main.bounds.height - 30)
            ScrollView {
//                Player(videoid: videoid, duration: $duration, isplay: $isplay)
                YoutubePlayer(videoId: videoid, duration: $duration, curretTime: $currentTime, isplay: $isplay, forward15: $forward15, goback15: $goback15)
                    .frame(width: playerSize.width,
                           height: playerSize.height)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(15)
                    .onAppear {
                        let frame = UIApplication.shared.windows.first?.frame ?? .zero
                        playerSize = CGSize(
                            width: frame.width - 20,
                            height: frame.width / 16*9
                        )
                    }
                Text(videotitle)
                    .font(.title3)
                
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                    Capsule().fill(Color.red).frame(width: self.width, height: 8)
                }
                HStack(spacing: UIScreen.main.bounds.width / 5 - 30) {
                    Button(action: {
                    
                    }) {
                        Image(systemName: "backward.fill").font(.title)
                    }
                    Button(action: {
                        if (forward15 == false) {
                            forward15 = true
                        }
                    }) {
                        Image(systemName: "goforward.15").font(.title)
                    }
                    Button(action: {
                        if (self.isplay) {
                            self.isplay = false
                        }
                        else {
                            self.isplay = true
                        }
                    }) {
                        Image(systemName: self.isplay ? "play.fill" : "pause.fill").font(.title)
                    }
                    Button(action: {
                        if (!goback15) {
                            goback15 = true
                        }
                        else {
                            goback15 = false
                        }
                    }) {
                        Image(systemName: "gobackward.15").font(.title)
                    }
                    Button(action: {
                    
                    }) {
                        Image(systemName: "forward.fill").font(.title)
                    }
                }.padding()
                .foregroundColor(Color.black)
                .onAppear {
                    let screen = UIScreen.main.bounds.width - 30
                    if (isplay) {
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (_) in
                            self.sample = self.currentTime
//                            var value = self.sample/self.duration
//                            self.width = screen*CGFloat(value)
                       }
                    }
                }
            }.padding()
        }
    }
}


