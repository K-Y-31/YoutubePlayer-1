//
//  TimerScheduler.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/12.
//

import SwiftUI
import Combine

class TimerScheduler: ObservableObject {
    @Published var timer: Timer!
    @Published var currenttime = 0
    @State var state: Int = 0
    
    init() {
        if (self.state == 0) {
            play()
        }
    }
    
    func play() {
        self.timer?.invalidate()
        self.currenttime = 0
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            self.currenttime += 1
        }
    }
}
