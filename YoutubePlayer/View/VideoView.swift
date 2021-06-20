//
//  VideoView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/05/31.
//

import SwiftUI
import YoutubeKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct VideoView: View {
    @ObservedObject var video = RequestController()
    @State var player: YTSwiftyPlayer!
    @Binding var isplay: Bool
    @ObservedObject var fetchuserinfo = FetchLoginUserInfo()
    @State var isSignout: Bool = false
    
    var body: some View {
            VStack {
                Text("急上昇")
                    .font(.headline)
                    .padding(.leading, 15)
                    .position(x: 80)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(video.hotdata) { item in
                            GeometryReader { geometry in
                                NavigationLink(destination: AudioPlayerView(videoid: item.id, videotitle: item.snippet.title, isplay: isplay)) {
                                    HotVideoCardView(video_info: item)
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -20),
                                                          axis: (x: 0, y: 10.0, z: 0))
                                }
                            }.frame(width: 246, height: 180)
                        }
                    }
                }.padding()
                Divider()
                Text("Favorite Music")
                    .font(.headline)
                    .padding(.leading, 15)
                    .position(x: 80)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(video.data) { item  in
                            GeometryReader { geometry in
                                NavigationLink(destination: AudioPlayerView(videoid: item.snippet.resourceId.videoId, videotitle: item.snippet.title, isplay: isplay)) {
                                    VideoCardView(video_info: item)
                                        .rotation3DEffect(
                                            Angle(degrees: Double(geometry.frame(in: .global).minX) / -20),
                                            axis: (x: 0, y: 10.0, z: 0))
                                }
                            }.frame(width: 246, height: 180)
                        }
                    }
                }
                .padding()
                
                Text("海外のMusic")
                    .font(.headline)
                    .padding(.leading, 15)
                    .position(x: 80)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(video.artistdata) { item in
                            GeometryReader { geometry in
                                NavigationLink(destination: AudioPlayerView(videoid: item.snippet.resourceId.videoId, videotitle: item.snippet.title, isplay: isplay)) {
                                    ArtistVideoCardView(video_info: item)
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -20),
                                                      axis: (x: 0, y: 10.0, z: 0))
                                }
                            }.frame(width: 246, height: 180)
                        }
                    }
                }
                .padding()
                Divider()
                Text("J-Lock")
                    .font(.headline)
                    .padding(.leading, 15)
                    .position(x: 80)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(video.jlockdata) { item in
                            GeometryReader { geometry in
                                NavigationLink(destination: AudioPlayerView(videoid: item.snippet.resourceId.videoId, videotitle: item.snippet.title, isplay: isplay)) {
                                    JlockCardView(video_info: item)
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -20),
                                                      axis: (x: 0, y: 10.0, z: 0))
                                }
                            }.frame(width: 246, height: 180)
                        }
                    }
                }.padding()
            }.foregroundColor(.black)
            .navigationBarItems(
                leading:
                    Button(action: {
                        do {
                            try Auth.auth().signOut()
                            self.isSignout = true
                        }
                        catch {
                            print("Failed logout: \(error)")
                        }
                    }) {
                        VStack {
                            Text("ログアウト")
                        }
                    },
                trailing:
                        Button(action: {
                            
                        }) {
                            URLImageView(viewModel: .init(url: self.fetchuserinfo.usermodel.profileImageUrl ?? "person.fill"))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        }
                
            )
            .fullScreenCover(isPresented: self.$isSignout) {
                SignInView()
            }
    }
}
