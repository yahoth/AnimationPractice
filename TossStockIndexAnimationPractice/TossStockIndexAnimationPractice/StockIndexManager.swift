//
//  StockIndexManager.swift
//  TossStockIndexAnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/06/01.
//

import Foundation
import Combine

class StockIndexManager: ObservableObject {
    @Published var stockIndices: [Item] = []
    var subscriptions = Set<AnyCancellable>()
    
    let serviceKey: String =     "%2BSnnzPdi8k9bxql5BywML%2BHrIw51%2F%2F7c%2FuaHvHdaGPQdMj8vyfmSMR4yTg1EASXO2PEeaoqvFH4CUcYZ6dNaQg%3D%3D"
    
//    let url: URL? = URL(string: "https://apis.data.go.kr/1160100/service/GetMarketIndexInfoService/getStockMarketIndex?serviceKey=%2BSnnzPdi8k9bxql5BywML%2BHrIw51%2F%2F7c%2FuaHvHdaGPQdMj8vyfmSMR4yTg1EASXO2PEeaoqvFH4CUcYZ6dNaQg%3D%3D&resultType=json&pageNo=&numOfRows=&basDt=20230531&idxNm=코스피")
    
    func request(date: String, name: String) {
        let url = "https://apis.data.go.kr/1160100/service/GetMarketIndexInfoService/getStockMarketIndex?serviceKey=\(serviceKey)&resultType=json&pageNo=&numOfRows=&basDt=\(date)&idxNm=코스닥"
        
//        let base = "https://apis.data.go.kr/"
//        let path = "1160100/service/GetMarketIndexInfoService/getStockMarketIndex"
//        let params = ["serviceKey": serviceKey, "basDt": date, "idxNm": name]
//        let header = ["Content-type": "application/json"]
//        
//        var urlComponents = URLComponents(string: base + path)!
//        let queryItems = params.map { (key: String, value: String) in
//            URLQueryItem(name: key, value: value)
//        }
//        urlComponents.queryItems = queryItems
//        var urlRequest = URLRequest(url: urlComponents.url!)
//        header.forEach { (key: String, value: String) in
//            urlRequest.addValue(value, forHTTPHeaderField: key)
//        }
        
        guard let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let encodedAndReplacingURL = encodedURL.replacingOccurrences(of: "%25", with: "%")
        guard let url = URL(string: encodedAndReplacingURL)  else {
            print(NetworkError.invalidRequest)
            return
        }
        
        URLSession(configuration: .default).dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode)
                else {
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                return result.data
            }
            .decode(type: StockIndex.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("error: \(error)")
                case .finished: break
                }
            } receiveValue: {
                print($0.response.body.items)
            }
            .store(in: &subscriptions)
    }
}
