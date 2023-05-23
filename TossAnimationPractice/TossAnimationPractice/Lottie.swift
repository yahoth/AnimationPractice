//
//  LottieView.swift
//  AnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/05/22.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.sizeToFit()
        return animationView
    }
    
    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
        
    }
}
