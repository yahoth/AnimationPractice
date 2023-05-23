//
//  ButtonCustom.swift
//  AnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/05/23.
//

import SwiftUI

struct TopButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? TossColor.buttonTappedColor : .white)
    }
}

struct ListCellButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? TossColor.buttonTappedColor : .white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeIn(duration: 0.2), value: configuration.isPressed)
    }
}
