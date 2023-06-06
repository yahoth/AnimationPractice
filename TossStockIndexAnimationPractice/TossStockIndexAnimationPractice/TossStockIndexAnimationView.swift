//
//  TossStockIndexAnimationView.swift
//  TossStockIndexAnimationPractice
//
//  Created by TAEHYOUNG KIM on 2023/06/01.
//

import SwiftUI
/// 과정`
/// HStack alignment가 firstTextBaseline 혹은 lastTextBaseline을 이용하면 글자를 기준으로 라인정렬이 된다. (사진)
///  근데 그러면 바닥에 붙어서 올라오질 않는다. 걍 패딩으로 위치 조절.
/// 고민
/// 1. 애니메이션 범위가 넓다
/// 2. 반복되는 과정을 어떻게 프로그래밍하면 좋을지
/// 3. 균등한 버튼 크기?? : .infinity쓰니 다행이 반반
/// 4. 빈 공간을 어떻게 채우띾? : vstack spacing 줄이고, offset 조절 -> 값을 다 받을 수 없으니 일일이 조절하는게 조금 아쉬움
/// 5. 디바이더  이동을 어떤 방식으로? 매치드 vs 트랜지션, 버튼 애니메이션!
/// 6. 디바이더 애니메이션이 이상하고, 위치가 계속 움직임: 사이즈가 고정되야함. 이경우엔 위쪽 스페이서를 고정시켜주니 ㄱㅊ
/// 7. 바텀 라인이 안지워지는데, 툴바에 넣으려고 하다보니 네비게이션바와는 다름. 네비게이션바는 지워지는데, 툴바는 안지워짐. 네비게이션을 쓰지말아버려? -> 오케 커스텀 네비 가자
/// 8. 타이머를 통해 애니메이션을 구현했는데 double 계산이 이상해서 어떻게하지?
///  -> 걍 타이머 하나 켜놓고 0.1 초단위로 실행하고, 몇초엔 이거, 몇초엔 이거, 다되면 타이머 초기화하면 되는거아닌가? ->
///  어려움1. double 계산이 이상하다.
///  어려움2. 균등하게 하기 어렵다..... 이걸 다시 해결해보쟈 -> 알고리즘같음.
///  지금 방식: 먼저 객체를 없앰. 0.4초 뒤에 객체 추가. 3.6초 뒤에 다시 실행.
///
///주의할점: 프리뷰랑 시뮬이랑 다르다.
///
/// 할일:
/// 네비바 밑에 라인 제거 0
/// offset에따라 투명도 조절하기
/// 그 밑에 디바이더넣기 0
/// 애니메이션 반복가능하도록 수정 0
/// 코드 리팩토링 -> 나의 주관을 세우는 과정이다!
/// 뷰모델 만들기
/// API 제거
struct TossColor {
    static let toolbarItemColor = Color(red: 0.384, green: 0.384, blue: 0.427)
}

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
                    VStack(spacing: 0) {
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
            .foregroundColor(TossColor.toolbarItemColor)
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

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct TossStockIndexAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TossStockIndexAnimationView()
    }
}
