//
//  VideoPlayer.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/05.
//

import Foundation
import SwiftUI
import youtube_ios_player_helper

//struct Player: UIViewRepresentable {
//    typealias UIViewType = YTSwiftyPlayer
//    @State var videoid: String
//    @Binding var duration: Double
//    @Binding var isplay: Bool
//
//    func makeCoordinator() -> Player.Coordinator {
//        return Coordinator(duration: $duration, isplay: $isplay)
//    }
//
//    func makeUIView(context: Context) -> YTSwiftyPlayer {
//        let player = YTSwiftyPlayer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 16 * 9), playerVars: [
//            .showRelatedVideo(false),
//        ])
//        player.delegate = context.coordinator
//        player.autoplay = true
//        return player
//    }
//
//    func updateUIView(_ uiView: YTSwiftyPlayer, context: Context) {
//        uiView.setPlayerParameters([
//            .playsInline(true),
//            .videoID(videoid)
//        ])
//        uiView.loadPlayer()
//    }
//}
//
//extension Player {
//    class Coordinator: NSObject, YTSwiftyPlayerDelegate {
//        @Binding var duration: Double
//        @Binding var isplay: Bool
//
//        init(duration: Binding<Double>, isplay: Binding<Bool>) {
//            _duration = duration
//            _isplay = isplay
//        }
//
//        func player(_ player: YTSwiftyPlayer, didChangeState state: YTSwiftyPlayerState) {
//            duration = player.duration ?? 0.0
//            print("\(player.currentTime)")
//            print("\(state.rawValue)")
//            if (isplay) {
//                player.playVideo()
//            }
//            else {
//                player.pauseVideo()
//            }
//        }
//
//
//        func player(_ player: YTSwiftyPlayer, didChangePlaybackRate playbackRate: Double) {
//
//            print("\(playbackRate)")
//        }
//
//        func player(_ player: YTSwiftyPlayer, didChangeQuality quality: YTSwiftyVideoQuality) {
//            print(quality.rawValue)
//        }
//
//    }
//}

struct YoutubePlayer: UIViewRepresentable {
    typealias UIViewType = YTPlayerView
    @State var videoId: String
    @Binding var duration: Double
    @Binding var curretTime: Double
    @Binding var isplay: Bool
    @Binding var forward15: Bool
    @Binding var goback15: Bool
    
    func makeCoordinator() -> YoutubePlayer.Coordinator {
        Coordinator(duration: $duration, currentTime: $curretTime, isplay: $isplay, forward15: $forward15, goback15: $goback15)
    }
    
    func makeUIView(context: Context) -> YTPlayerView {
        let player = YTPlayerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 16*9))
        player.delegate = context.coordinator
        return player
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        uiView.load(withVideoId: videoId)
    }
}

extension YoutubePlayer {
    class Coordinator: NSObject, YTPlayerViewDelegate {
        @Binding var duration: Double
        @Binding var currentTime: Double
        @Binding var isplay: Bool
        @Binding var forward15: Bool
        @Binding var goback15: Bool
        
        init(duration: Binding<Double>, currentTime: Binding<Double>, isplay: Binding<Bool>, forward15: Binding<Bool>, goback15: Binding<Bool>) {
            _duration = duration
            _currentTime = currentTime
            _isplay = isplay
            _forward15 = forward15
            _goback15 = goback15
        }
        
        func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
            print("\(playTime)")
            self.currentTime = Double(playTime)
            if (forward15) {
                playerView.seek(toSeconds: Float(self.currentTime) + 15, allowSeekAhead: true)
            }
        }
        
        func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
            playerView.playVideo()
            playerView.duration { (duration, error) in
                self.duration = duration
                print("\(duration)")
                if ((error) != nil) {
                    fatalError("Failed getting suration time: \(error!)")
                }
            }
            
            if (goback15) {
                playerView.seek(toSeconds: -15, allowSeekAhead: true)
            }
        }
        
        func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
            if (forward15) {
                playerView.seek(toSeconds: 15, allowSeekAhead: true)
            }
            else if (goback15) {
                playerView.seek(toSeconds: -15, allowSeekAhead: true)
            }
            if (isplay) {
                playerView.playVideo()
            }
            else {
                playerView.stopVideo()
            }
        }
    }
}

