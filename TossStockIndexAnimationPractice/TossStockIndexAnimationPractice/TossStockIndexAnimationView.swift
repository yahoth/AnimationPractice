//
//  TossStockIndexAnimationView.swift
//  TossStockIndexAnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/06/01.
//

import SwiftUI

struct TossStockIndexAnimationView: View {
    @ObservedObject var vm = TossStockIndexAnimationViewModel()
    @State var offsetValue: Double = 0
    @State var selection = 1
    
    var opacity: Double {
         offsetValue / 30
    }
    
    var body: some View {
        NavigationStack {
            
            toolbarItems()
            
            Spacer()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(spacing: -12) {
                        HStack(alignment: .center, spacing: 10) {
                            
                            Text("토스증권")
                                .font(.title)
                                .fontWeight(.semibold)
                                .baselineOffset(12)
                            
                            stockIndexAnimation()
                                .font(.footnote)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .background(.white)
                        
                        HStack(spacing: 12) {
                            selectTabButton(tabIndex: 1, tabName: "내 주식")
                            selectTabButton(tabIndex: 2, tabName: "오늘의 발견")
                        }
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                        .background(Color.white)
                        .overlay {
                            VStack {
                                Spacer()
                                Divider()
                            }
                        }
                        .offset(y: offsetValue >= 42 ?  offsetValue - 42 : 0)
                    }
                    
                    mockImages()
                    
                }
                .background(
                    GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self,
                                               value: -$0.frame(in: .named("scroll")).origin.y)
                    }
                )
                .onPreferenceChange(ViewOffsetKey.self) {
                    offsetValue = $0
                }
                Spacer()
            }
            .coordinateSpace(name: "scroll")
        }
    }
    
    @ViewBuilder
    
    func stockIndexAnimation() -> some View {
        if let stock = vm.stock {
            HStack(spacing: 4) {
                Text(stock.name)
                    .foregroundColor(.gray)
                Text(stock.closePrice)
                    .foregroundColor(Double(stock.vs)! > 0 ? .red : .blue)
            }
            .fontWeight(.semibold)
            .transition(.asymmetric(insertion: .move(edge: .bottom),
                                    removal: .push(from: .bottom)))
        }
    }
    
    func selectTabButton(tabIndex: Int, tabName: String) -> some View {
        VStack(spacing: 0) {
            Spacer(minLength: 10)
            Text(tabName)
                .font(.system(size: 18))
                .foregroundColor(selection == tabIndex ? .black : .gray)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(
                    .white)
            Spacer()
            if selection == tabIndex {
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(selection == tabIndex ? .black : .white)
                    .transition(.move(edge: tabIndex == 1 ? .trailing : .leading))
            }
        }
        .onTapGesture {
            withAnimation() {
                selection = tabIndex
            }
        }
    }
    
    func toolbarItems() -> some View {
        HStack {
            stockIndexAnimation()
                .opacity(opacity)
            
            Spacer()
            
            HStack(spacing: 20) {
                Button {
                    //
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                
                Button {
                    //
                } label: {
                    Image(systemName: "checkmark.square.fill")
                }
                Button {
                    //
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
            .font(.title2)
            .foregroundColor(Color(red: 0.384, green: 0.384, blue: 0.427))
        }
        .padding(.horizontal, 20)
        .padding(.top, 5)
    }
    
    func mockImages() -> some View {
        Group {
            Image(selection == 1 ? "toss1" : "toss3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .zIndex(-1)
            Image(selection == 1 ? "toss2" : "toss4")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .zIndex(-1)
        }
    }
}

struct TossStockIndexAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TossStockIndexAnimationView()
    }
}
