//
//  ViewWillApperHandler.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/19.
//

import Foundation
import SwiftUI

struct ViewWillAppearHandler: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    let onWillAppear: () -> Void
    
    func makeCoordinator() -> ViewWillAppearHandler.Coordinator {
        Coordinator(onWillAppear: onWillAppear)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewWillAppearHandler>) -> UIViewController {
        context.coordinator
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

extension ViewWillAppearHandler {
    class Coordinator: UIViewController {
        let onWillAppear: () -> Void
        
        init(onWillAppear: @escaping () -> Void) {
            self.onWillAppear = onWillAppear
            super.init(nibName: nil, bundle: nil)
        }
        
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemeted")
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            onWillAppear()
        }
    }
}

struct ViewWillAppearModifier: ViewModifier {
    let callback: () -> Void
    
    func body(content: Content) -> some View {
        content
            .background(ViewWillAppearHandler(onWillAppear: callback))
    }
}

extension View {
    func onWillAppear(_ perform: @escaping (() -> Void)) -> some View {
        self.modifier(ViewWillAppearModifier(callback: perform))
    }
}
