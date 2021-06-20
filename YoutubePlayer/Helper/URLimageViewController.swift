//
//  URLimageViewController.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/02.
//

import Foundation
import SwiftUI

class URLImageViewController: ObservableObject {
    @Published var downloadData: Data? = nil
    let url: String
    
    init(url: String, isSync: Bool = false) {
        self.url = url
        if isSync {
            self.downloadImageSync(url: self.url)
        }
        else {
            self.downloadImageAsync(url: self.url)
        }
    }
    
    private func downloadImageAsync(url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            do {
                let data = try? Data(contentsOf: imageURL)
                DispatchQueue.main.async {
                    self.downloadData = data
                }
            }
        }
    }
    
    private func downloadImageSync(url: String) {
        guard let imageURL = URL(string: url) else { return }
        let data = try? Data(contentsOf: imageURL)
        self.downloadData = data
    }
}
