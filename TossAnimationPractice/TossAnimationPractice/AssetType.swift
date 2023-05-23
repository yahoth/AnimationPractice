//
//  AssetType.swift
//  AnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/05/23.
//

import Foundation

struct AssetType {
    let assetName: String
    let accountBalance: String
    let imageName: String
    let isAccount: Bool
    let isShowLogoAnimation: Bool
    
    static let assets = [
        AssetType(assetName: "IBK기업은행 계좌", accountBalance: "?원", imageName: "ibk", isAccount: true, isShowLogoAnimation: false),
        AssetType(assetName: "내 모든 계좌", accountBalance: "잔액 보기", imageName: "Market", isAccount: true, isShowLogoAnimation: true),
        AssetType(assetName: "투자 ∙ 토스증권", accountBalance: "잔액 보기", imageName: "toss", isAccount: false, isShowLogoAnimation: false)
    ]
}
