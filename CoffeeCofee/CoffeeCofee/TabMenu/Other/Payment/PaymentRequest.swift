//
//  PaymentRequest.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/11/18.
//

import SwiftUI
import Combine

struct PaymentRequest: View {
    @EnvironmentObject var paymentPresenter: PaymentModel
    
    @State private var userRequest: String = ""    
    @State private var shopRequest :[String] = ["매장", "포장"]
    @State private var select_request: String = "매장"
        
    var body: some View {
        VStack {
            Text("요청사항")
            Text("매장 요청사항")
            TextField("요청사항을 입력하세요", text: $userRequest)
                .onChange(of: userRequest) { _ in
                    paymentPresenter.paymentData.userRequest = userRequest
                }
            Text("포장 요청사항")
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                ForEach(shopRequest, id: \.self) { radioData in
                    PaymentItemListRadio(title: radioData, isSelected: select_request == radioData) {
                        select_request = radioData
                        
                        
                    }
                }
            }
            .onChange(of: select_request) { newValue in
                paymentPresenter.paymentData.shopRequest = newValue
            }
            
        }
        .onAppear {
            paymentPresenter.paymentData.shopRequest = select_request
        }
    }
}


