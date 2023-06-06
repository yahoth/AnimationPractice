//
//  StockIndex.swift
//  TossStockIndexAnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/06/05.
//

import Foundation

struct StockIndex: Codable {
    let name: String // 지수 이름: [코스피, 코스닥]
    let closePrice: String // 종가
    let vs: String // 대비
}

extension StockIndex {
    static let stocks = [
        StockIndex(name: "다우존스", closePrice: "33,562.86", vs: "-199.90"),
        StockIndex(name: "환율", closePrice: "1,303.31", vs: "-5.49"),
        StockIndex(name: "나스닥", closePrice: "13,229.43", vs: "-11.34"),
        StockIndex(name: "S&P 500", closePrice: "4,273.79", vs: "-8.58")
    ]
}
