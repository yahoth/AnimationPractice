//
//  StockIndex.swift
//  TossStockIndexAnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/06/05.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case responseError(statusCode: Int)
    case jsonDecodingError(error: Error)
}

struct StockIndex: Codable {
    let response: Response
}

struct Response: Codable {
    let body: Body
}

struct Body: Codable {
    let items: Items
}

struct Items: Codable {
    let item: [Item]
}

struct Item: Codable {
    let date: String // 날짜: "20230602"
    let name: String // 지수 이름: [코스피, 코스닥]
    let closePrice: String // 종가
    let vs: String // 대비
    let fluctuationRate: String // 등락률
    
    enum CodingKeys: String, CodingKey {
        case date = "basDt" // 날짜: "20230602"
        case name = "idxNm" // 지수 이름: [코스피, 코스닥]
        case closePrice = "clpr" // 종가
        case vs // 대비
        case fluctuationRate = "fltRt" // 등락률
    }
}

extension Item {
    static let items = [
        Item(date: "20230605", name: "코스피", closePrice: "2,615,41", vs: "14.05", fluctuationRate: "0.5"),
        Item(date: "20230605", name: "코스닥", closePrice: "870.28", vs: "2.22", fluctuationRate: "0.2"),
        Item(date: "20230605", name: "나스닥", closePrice: "13,240.77", vs: "139.79", fluctuationRate: "1.0")
    ]
}
