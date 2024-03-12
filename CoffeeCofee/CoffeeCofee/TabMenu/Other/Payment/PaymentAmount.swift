//
//  PaymentAmount.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/11/21.
//

import SwiftUI
import FirebaseAuth

struct PaymentAmount: View {
    
    var shopName: String
    
    @EnvironmentObject var cartPresenter: OrderCartViewModel
    @EnvironmentObject var couponPresenter: MembershipCouponModel
    @EnvironmentObject var paymentPresenter: PaymentModel
    
    @State var cartPrice: Int = 0
    @State var discountPrice: Int = 0
    @State var totalPrice: Int = 0
    
    init(shopName: String) {
        self.shopName = shopName
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("상품 금액")
                Spacer()
                Text("\(cartPresenter.totalPriceByShop[shopName] ?? 0) 원")
            }
            
            HStack {
                Text("할인 금액")
                Spacer()
                Text("\(couponPresenter.selectedCoupon?.discountAmount ?? 0) 원")
            }
            
            HStack {
                Text("결제 금액")
                Spacer()
                Text("\(totalPrice) 원")
            }
        }
        .onChange(of: couponPresenter.selectedCoupon) { newSelectedCoupon in
            cartPrice = cartPresenter.totalPriceByShop[shopName] ?? 0
            discountPrice = couponPresenter.selectedCoupon?.discountAmount ?? 0
            
            if (cartPrice - discountPrice) > 0 {
                totalPrice = cartPrice - discountPrice
                paymentPresenter.paymentData.price = totalPrice
            }
        }
        .onAppear {
            cartPrice = cartPresenter.totalPriceByShop[shopName] ?? 0
            discountPrice = couponPresenter.selectedCoupon?.discountAmount ?? 0
            
            if (cartPrice - discountPrice) > 0 {
                totalPrice = cartPrice - discountPrice
                paymentPresenter.paymentData.price = totalPrice
            }
        }
    }
}

