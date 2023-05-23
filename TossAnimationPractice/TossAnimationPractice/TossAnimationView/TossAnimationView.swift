//
//  TossAnimationView.swift
//  AnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/05/22.
//

import SwiftUI

/// 고민
/// 1. 셀 모양을 도형으로하여 오버레이, 도형으로 하여 Zstack, 스택의 백그라운드로 할지
/// 2. 스택으로 할지, 오버레이로 할지
/// 3. 버튼은 buttonProminent로 하여 코너만 살짝 조정
/// 4. 애니메이션은 토스에서 Lottie를 사용함.
/// 5. 아마 logoIcon은 디자인을 하여 넣었을텐데 그게 더 귀찮아서 코드로 모양 만듦. 다음엔 figma를 이용해봐야지. 해보니 로고가 사이즈도 달라서 이 편이 훨씬 좋았을듯함.
/// 6. 버튼 커스텀 -> 이전에 해본적 있어서 어렵지 않았음
/// 어려웠던 점
/// 제일 까다로웠던것은 UI의 spacing, padding 이었음.
/// 코드를 깔끔하게 하는 것이 습관이 안되서 마무리하고 정리하기로.
/// 기준: 모디파이어로 각 attribute를 만들기보단 셀기준으로 정리



struct TossAnimationView: View {
    var body: some View {
        ZStack {
            
            TossColor.backgrountColor
            
            VStack(alignment: .leading) {
                topButton()
                
                ForEach(AssetType.assets, id: \.assetName) { asset in
                    listCellButton(asset: asset)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 312)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func topButton() -> some View {
        Button {
            print("자산 버튼 클릭")
        } label: {
            HStack {
                Text("자산")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.right")
                    .font(.footnote)
                    .foregroundColor(TossColor.arrowColor)
            }
            .padding(EdgeInsets(top: 22, leading: 20, bottom: 10, trailing: 20))
        }
        .buttonStyle(TopButtonStyle())
        .tint(.white)
    }
    
    func listCellButton(asset: AssetType) -> some View {
        Button {
            print("\(asset.imageName) clicked")
        } label: {
            HStack(alignment: .center, spacing: 16) {
                if asset.isShowLogoAnimation {
                    LottieView(name: asset.imageName, loopMode: .loop)
                        .scaleEffect(0.06)
                        .frame(width: 40, height: 40)
                } else {
                    ZStack {
                        Circle()
                            .fill(TossColor.ibkLogoBackgroundColor)
                        Image(asset.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(asset.assetName)
                        .foregroundColor(TossColor.accountNameColor)
                        .font(.footnote)
                    Spacer()
                    Text(asset.accountBalance)
                        .font(.body)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                if asset.isAccount {
                    Button {
                        //
                    } label: {
                        Text("송금")
                            .font(.footnote)
                            .padding(2)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(TossColor.sendButtonTintColor)
                    .cornerRadius(8)
                    .foregroundColor(.black)
                }
            }
            .frame(height: 40)
            .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
        }
        .buttonStyle(ListCellButtonStyle())
    }
}

struct TossAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TossAnimationView()
    }
}

