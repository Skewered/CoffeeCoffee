//
//  PaymentMethod.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/11/20.
//

import SwiftUI

struct PaymentMethod: View {
    
    @State private var methodList :[String] = ["선불카드", "신용카드", "네이버페이", "카카오페이", "페이코", "KB Pay", "하나 Pay"]
    @State private var select_method: String = "선불카드"
    
    @EnvironmentObject var paymentPresenter: PaymentModel
    
    var body: some View {
        VStack {
            Text("결제 수단")
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                ForEach(methodList, id: \.self) { radioData in
                    PaymentItemListRadio(title: radioData, isSelected: select_method == radioData) {
                        select_method = radioData
                        
                        paymentPresenter.paymentData.method = radioData
                    }
                }
            }
        }
        .onAppear {
            paymentPresenter.paymentData.method = select_method
        }
    }
}
