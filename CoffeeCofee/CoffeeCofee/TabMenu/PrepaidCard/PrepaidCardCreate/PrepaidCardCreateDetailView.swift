//
//  PrepaidCardCreateDetailView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct PrepaidCardCreateDetailView<T: PrepaidCardImageProtocol>: View {
    var data: T
    
    @EnvironmentObject var prepaidCardPresenter: PrepaidCardViewModel
    
    @State private var createCard = PrepaidCardData()
    @State private var chargeAmount: Int = 10000
    @State private var selectedPaymentMethod: String = "신용카드"
    @State private var cardName: String = ""
    @State private var items :[Int] = [10000, 20000, 30000, 50000, 100000, 200000, 300000]
    @State private var showingPrepaidCardView = false
    @State private var selectedTab = 1

    var body: some View {
        VStack {
            Group {
                VStack {
                    Text("디자인 선택")
                    Image(data.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
            }
            Group{
                VStack {
                    Text("카드 이름")
                    TextField("카드 이름", text: $cardName)
                    Text("카드 이름은 메가선불카드에서 변경하실 수 있습니다.")
                }
            }
            
            Group {
                VStack {
                    Text("충전금액")
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
                        ForEach(items, id: \.self) { radioData in
                            PrepaidCardCreateRadio(title: radioData, isSelected: chargeAmount == radioData) {
                                chargeAmount = radioData
                            }
                        }
                    }
                }
            }
            
            Group {
                HStack {
                    Text("결재 수단")
                    Picker(selection: $selectedPaymentMethod, label: Text("")) {
                        ForEach(["신용카드", "현금", "계좌이체"], id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
            }
            
            Group {
                VStack {
                    HStack {
                        Text("결제금액")
                        Text("\(chargeAmount) 원")
                    }
                    
                    PrepaidPrecautionsView()
                    PrepaidRefundView()
                }
            }
            Button(action: {
                createCard.cardName = cardName
                createCard.chargeAmount = chargeAmount
                createCard.design = data.rawValue
                createCard.paymentMethod = selectedPaymentMethod
                 
                prepaidCardPresenter.savePrepaidCards(item: createCard)
                
                prepaidCardPresenter.fetchPrepaidCards()
                showingPrepaidCardView = true
            }) {
                Text("결제하기")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .frame(width: 300, height: 40)
            .background(Color.brown)
            .cornerRadius(20)
            .fullScreenCover(isPresented: $showingPrepaidCardView) {
                MainTabView(selectedTab: $selectedTab)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
