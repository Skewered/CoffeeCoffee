//
//  PrepaidCardChargeView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct PrepaidCardChargeView: View {
    var data: PrepaidCardData
    
    @State private var chargeAmount: Int = 10000
    @State private var selectedPaymentMethod: String = "신용카드"
    @State private var cardName: String = ""
    @State private var items :[Int] = [10000, 20000, 30000, 50000, 100000, 200000, 300000]
    @State private var showingPrepaidCardView = false
    @State private var selectedTab = 1

    @EnvironmentObject var prepaidCardPresenter: PrepaidCardViewModel

    var ref: DatabaseReference! = Database.database().reference() //
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    Image(data.design)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    VStack {
                        Text("\(data.cardName)")
                        Text("\(data.chargeAmount)")
                    }
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
                    Text("메가선불카드는 충전 후 총액이 50만원을 초과할 수 없습니다.")
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
                prepaidCardPresenter.chargeDataToFirebase(cardId: data.id, chargeAmount: data.chargeAmount, newChargeAmount: chargeAmount)
                
                prepaidCardPresenter.fetchPrepaidCards()
                showingPrepaidCardView = true
            }) {
                Text("카드 충전")
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
