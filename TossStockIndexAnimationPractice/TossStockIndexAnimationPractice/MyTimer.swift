//
//  MyTimer.swift
//  TossStockIndexAnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/06/05.
//

import Foundation
import SwiftUI

class MyTimer: ObservableObject {
    
    @Published var stock: Item? = Item.items[0]
    
    var value1: Double = 0
    var value2: Double = 0
    
    init() {
        stockRemove(time: 3)
        stockRemove(time: 6.6)
        stockRemove(time: 10.2)

        stockApear(time: 3.4, idx: 1)
        stockApear(time: 7.0, idx: 2)
        stockApear(time: 10.6, idx: 0)
    }
    
    func stockRemove(time: Double) {
        Timer.scheduledTimer(withTimeInterval: time, repeats: true) { timer in
                withAnimation(.easeOut(duration: 0.3)) {
                    self.stock = nil
                }
                timer.invalidate()
        }
    }
    func stockApear(time: Double, idx: Int) {
        Timer.scheduledTimer(withTimeInterval: time, repeats: true) { timer in
            withAnimation(.easeIn(duration: 0.3)) {
                    self.stock = Item.items[idx]
                }
                timer.invalidate()
        }
    }

}

///토스: 기존께 없어지고 잠깐 후에 올라옴
///현재: 없어지려고 올라감과 동시에 올라옴

///애니메이션 원리: value가 바뀌면 기존의 if문이 없어지면서 0.3초 동안 없어짐
///그렇다면? value가 바뀌는 속도는 어쩌지 못할 것 같고, 밸류가 바뀌면 없어지던걸 추가 변수를 줘서 밸류보다 0.1초 빨리 바뀌게한다면?
///없어지고 0.1초후에 올라오지 않을까?

/// value1
/// value2
/// value3
/// value4
/// value5

/// timer는 timeInterval 마다 함수를 실행할 수 있다. 지수를 변수에 할당시켜놓고 3.3초 단위로 생기게 한다.
/// 3초가 되면, 변수를 nil로 만든다.
/// 3.3초가 되면 변수를 다시 할당한다.
