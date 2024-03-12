//
//  PaymentCashreceipt.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/11/20.
//

import SwiftUI
import Combine

struct PaymentCashreceipt: View {
    
    @State private var cashreceiptList :[String] = ["신청 안함", "개인 소득공제", "사업자 증빙"]
    @State private var select_cashreceip: String = "신청 안함"
    @State var userCashreceip: String = ""
    
    @EnvironmentObject var paymentPresenter: PaymentModel
    
    var body: some View {
        VStack {
            Text("현금영수증")
            
            HStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                    ForEach(cashreceiptList, id: \.self) { radioData in
                        PaymentItemListRadio(title: radioData, isSelected: select_cashreceip == radioData) {
                            select_cashreceip = radioData
                            paymentPresenter.paymentData.cashreceipt = radioData
                        }
                    }
                }
            }
            TextField("현금영수증을 등록할 휴대전화 번호를 입력하세요", text: $userCashreceip)
                .keyboardType(.numberPad)
                .onReceive(Just(userCashreceip)) { input in
                    let filtered = input.filter { "0123456789".contains($0) }
                    if filtered != input {
                        userCashreceip = String(filtered.prefix(11)) 
                        paymentPresenter.paymentData.cashUserReceipt = userCashreceip
                    }
                }
        }
        .onAppear {
            paymentPresenter.paymentData.cashreceipt = select_cashreceip
        }
    }
}


