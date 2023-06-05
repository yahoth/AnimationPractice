//
//  ContentView.swift
//  TossAnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/05/23.
//

import SwiftUI

struct ContentView: View {
    
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
            print("\(asset.assetName) clicked")
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
                        .foregroundColor(.black)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
