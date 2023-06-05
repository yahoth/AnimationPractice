//
//  ContentView.swift
//  TossStockIndexAnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/06/01.
//

import SwiftUI
/// 과정
/// HStack alignment가 firstTextBaseline 혹은 lastTextBaseline을 이용하면 글자를 기준으로 라인정렬이 된다. (사진)
///  근데 그러면 바닥에 붙어서 올라오질 않는다. 걍 패딩으로 위치 조절.
///
struct ContentView: View {
        @ObservedObject var timer = MyTimer()
    @State var offsetValue: Double = 0
    
    var opacity: Double {
         offsetValue / 40
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // 네비게이션 타이틀 부분
                    HStack(alignment: .center, spacing: 10) {
                        Text("토스증권")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .baselineOffset(12)
                        stockIndexAnimation()
                    }
                    HStack {
                        Text("내 주식")
                        Text("오늘의 발견")
                    }
                    .frame(maxWidth: .infinity)

                    Spacer()
                    VStack(spacing: 20) {
                        ForEach(1..<30) { num in
                            
                            Text("item: \(num)")
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey.self,
                                           value: -$0.frame(in: .named("scroll")).origin.y)
                })
                .onPreferenceChange(ViewOffsetKey.self) {
                    offsetValue = $0
                }
            }
            .background(Color(red: 0.095, green: 0.09, blue: 0.116))
            .coordinateSpace(name: "scroll")
            .toolbarBackground(Color(red: 0.095, green: 0.09, blue: 0.116), for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    stockIndexAnimation()
                        .font(.title2)
                        .opacity(opacity)
                }
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .foregroundColor(Color(red: 0.384, green: 0.384, blue: 0.427))
                    
                    Button {
                        //
                    } label: {
                        Image(systemName: "checkmark.square.fill")
                    }
                    .foregroundColor(Color(red: 0.384, green: 0.384, blue: 0.427))

                    Button {
                        //
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .foregroundColor(Color(red: 0.384, green: 0.384, blue: 0.427))


                }
                
            }
        }
    }
    
    @ViewBuilder
    func stockIndexAnimation() -> some View {
        if let stock = timer.stock {
            HStack(spacing: 4) {
                Text(stock.name)
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                Text(stock.closePrice)
                    .foregroundColor(.red)
            }
            .transition(.asymmetric(insertion: .move(edge: .bottom),
                                    removal: .push(from: .bottom)))
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
