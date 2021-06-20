//
//  URLImageView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/02.
//

import Foundation
import SwiftUI

struct URLImageView: View {
    @ObservedObject var viewModel: URLImageViewController
    var body: some View {
        if let imageData = self.viewModel.downloadData {
            if let image = UIImage(data: imageData) {
                return Image(uiImage: image).resizable()
            } else {
                return Image(uiImage: UIImage()).resizable()
            }
        } else {
            return Image(uiImage: UIImage()).resizable()
        }
    }
}
