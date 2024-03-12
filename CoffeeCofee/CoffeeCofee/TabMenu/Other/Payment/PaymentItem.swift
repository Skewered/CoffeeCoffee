//
//  PaymentItem.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/11/18.
//

import SwiftUI

struct PaymentItem: View {
    var shopName: String
    
    @EnvironmentObject var cartPresenter: OrderCartViewModel
    @EnvironmentObject var paymentPresenter: PaymentModel
    
    @State private var showPrecautions = false
    @State private var cartItemsForShop: [CartItemData] = []

    var body: some View {
        VStack{
            Text("주문 상품")
            
            HStack {
                Text("상품 명")
                Spacer()
                Button(action: {
                    showPrecautions.toggle()
                }) {
                    Image(systemName: showPrecautions ?  "arrow.up" : "arrow.down")
                }
            }
            
            VStack {
                if showPrecautions {
                    PaymentItemList(shopName: shopName)
                }
            }
        }
    }
}


