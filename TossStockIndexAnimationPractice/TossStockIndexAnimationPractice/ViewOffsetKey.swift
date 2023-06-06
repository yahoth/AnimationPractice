//
//  ViewOffsetKey.swift
//  TossStockIndexAnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/06/07.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
