//
//  PaymentView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/11/17.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var paymentPresenter: PaymentModel
    @EnvironmentObject var cartPresenter: OrderCartViewModel
    @EnvironmentObject var couponPresenter: MembershipCouponModel
    @EnvironmentObject var stampPresenter: MembershipStampModel

    @State private var isPaymentComplete = false
    @State private var cartItemsForShop: [CartItemData] = []
    @State private var selectedTab = 0
    
    var shopName: String
    
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                PaymentItem(shopName: shopName)
                PaymentRequest()
                PaymentCoupon()
                PaymentMethod()
                PaymentCashreceipt()
                PaymentAmount(shopName: shopName)
                
                Button(action: {
                    
                    paymentPresenter.savePaymentDataToFirebase(paymentData: paymentPresenter.paymentData )
                    paymentPresenter.saveStampDataToFirebase(shopName: shopName)
                    paymentPresenter.deleteCartItems(cartItemsToDelete: cartPresenter.cartItemsForShop)
                    stampPresenter.createStampDetailDatas()
                    
                    if let selectedCoupon = couponPresenter.selectedCoupon {
                        couponPresenter.deleteCouponData(couponDataToDelete: selectedCoupon)
                    }
                    
                    stampPresenter.fetchstampDatas {
                        if stampPresenter.stampData.count >= 3 {
                            stampPresenter.deleteStampDataToFirebase()
                            couponPresenter.createCouponDatas()
                            couponPresenter.createCouponDetailDatas()
                        }
                    }
                    
                    isPaymentComplete = true
                }) {
                    Text("결제하기")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .frame(width: 300, height: 40)
                .background(Color.brown)
                .cornerRadius(20)
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("<")
                }
            }
        }
        .navigationBarTitle("\(shopName)", displayMode: .inline)
        .fullScreenCover(isPresented: $isPaymentComplete) {
            MainTabView(selectedTab: $selectedTab)
        }
    }
}
