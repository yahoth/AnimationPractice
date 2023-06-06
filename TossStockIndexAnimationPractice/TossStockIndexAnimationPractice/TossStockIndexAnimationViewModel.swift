//
//  TossStockIndexAnimationViewModel.swift
//  TossStockIndexAnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/06/05.
//

import Foundation
import SwiftUI

class TossStockIndexAnimationViewModel: ObservableObject {
    
    @Published var stock: StockIndex? = StockIndex.stocks[0]
    let stocks = StockIndex.stocks

    var time = 0
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] timer in
            time += 1
            
            if time == 30 {
                withAnimation(.easeOut) {
                    stock = nil
                }
            }
            if time == 34 {
                withAnimation(.easeIn) {
                    stock = stocks[1]
                }
            }
            if time == 64 {
                withAnimation(.easeOut) {
                    stock = nil
                }
            }
            if time == 68 {
                withAnimation(.easeIn) {
                    stock = stocks[2]
                }
            }
            if time == 98 {
                withAnimation(.easeOut) {
                    stock = nil
                }
            }
            if time == 102 {
                withAnimation(.easeIn) {
                    stock = stocks[3]
                }
            }
            if time == 132 {
                withAnimation(.easeOut) {
                    stock = nil
                }
            }
            if time == 136 {
                withAnimation(.easeIn) {
                    stock = stocks[0]
                }
                time = 0
            }

        }
    }
}
