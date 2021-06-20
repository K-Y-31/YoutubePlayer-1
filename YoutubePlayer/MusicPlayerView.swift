//
//  MusicPlayerView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/05/30.
//

import SwiftUI
import AVKit

struct MusicPlayerView: View {
    @State var data: Data = .init(count: 0)
    @State var player: AVAudioPlayer!
    @State var playing = false
    @State var width: CGFloat = 0
    @State var songs = ["Sample", "Sample2"]
    @State var titles = ["夜に駆ける", "うっせーわ"]
    @State var current = 0
    @State var title = ""
    @State var finish = false
    @State var del = AVdelegate()
    
    var body: some View {
        VStack(spacing: 20) {
            Image(uiImage: self.data.count == 0 ? UIImage(named: self.titles[self.current])! : UIImage(data: self.data)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: self.data.count == 0 ? 250 : nil, height: 250)
                .cornerRadius(15)
            Text(self.titles[self.current]).font(.title).padding(.top)
            ZStack(alignment: .leading) {
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                Capsule().fill(Color.red).frame(width: self.width, height: 8)
                    .gesture(DragGesture()
                                .onChanged({ (value) in
                                    let x = value.location.x
                                    self.width = x
                                    
                                }).onEnded({ (value) in
                                    let x = value.location.x
                                    let screen = UIScreen.main.bounds.width
                                     - 30
                                    let parcent = x / screen
                                    self.player.currentTime = Double(parcent) * self.player.duration
                                }))
            }
            .padding(.top)
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30
            ) {
                Button(action: {
                    if self.current > 0 {
                        self.current -= 1
                    }
                    else {
                        self.current = self.songs.count - 1
                    }
                    self.ChangeSong()
                }) {
                    Image(systemName: "backward.fill").font(.title)
                }
                Button(action: {
                    let decrease = self.player.currentTime - 15
                    if self.player.duration > 0 {
                        self.player.currentTime = decrease
                        
                    }
                }) {
                    Image(systemName: "gobackward.15").font(.title)
                }
                Button(action: {
                    if self.player.isPlaying {
                        self.player.pause()
                        self.playing = false
                    }
                    else {
                        if self.finish {
                            self.finish = false
                            self.player.currentTime = 0
                            self.width = 0
                        }
                        self.player.play()
                        self.playing = true
                    }
                }) {
                    Image(systemName: self.playing && !self.finish ? "pause.fill" : "play.fill").font(.title)
                }
                Button(action: {
                    let increase = self.player.currentTime + 15
                    if increase < self.player.duration {
                        self.player.currentTime = increase
                    }
                }) {
                    Image(systemName: "goforward.15").font(.title)
                }
                Button(action: {
                    if self.songs.count - 1 != self.current {
                        self.current += 1
                    }
                    else {
                        self.current = 0
                    }
                    self.ChangeSong()
                }) {
                    Image(systemName: "forward.fill").font(.title)
                }
            }.padding(.top, 25)
            .foregroundColor(.black)
        }.padding()
        .onAppear {
            let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
         
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            self.player.prepareToPlay()
            self.player.delegate = self.del
            self.getData()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                if self.player.isPlaying {
                    let screen = UIScreen.main.bounds.width - 30
                    let value = self.player.currentTime / self.player.duration
                    self.width = screen * CGFloat(value)
                }
            }
            NotificationCenter.default
                .addObserver(forName: Notification.Name("Finish"), object: nil, queue: .main) { (_) in
                    self.finish = true
                }
        }
    }
    
    func getData() {
        let asset = AVAsset(url: self.player.url!)
        for item in asset.commonMetadata {
            if item.commonKey?.rawValue == "artwork" {
                let data = item.value as! Data
                self.data = data
            }
            if item.commonKey?.rawValue == "title" {
                self.title = self.titles[self.current]
                
            }
        }
    }
    
    func ChangeSong() {
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
     
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        self.data = .init(count: 0)
        self.title = self.titles[self.current]
        self.player.prepareToPlay()
        self.getData()
        self.player.play()
        self.finish = false
        self.player.delegate = self.del
    }
}

struct MusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerView()
    }
}

class AVdelegate: NSObject, AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: Notification.Name("Finish"), object: nil)
    }
}
