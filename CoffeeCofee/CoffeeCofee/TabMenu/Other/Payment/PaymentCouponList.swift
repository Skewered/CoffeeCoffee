//
//  PaymentCouponList.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/11/20.
//

import SwiftUI
import FirebaseAuth

struct PaymentCouponList: View {
    @EnvironmentObject var couponPresenter: MembershipCouponModel
    @EnvironmentObject var paymentPresenter: PaymentModel

    @StateObject var loginPresenter = LoginViewModel()

    var body: some View {
        let userUID = loginPresenter.initializeUserID()

        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(couponPresenter.couponData.filter({ $0.couponTapInfo == "have" && $0.userId == userUID })) { coupon in
                        MembershipCouponCell(coupon: coupon)
                            .onTapGesture {
                                if couponPresenter.selectedCoupon == coupon {
                                    couponPresenter.clearSelectedCoupon()
                                    paymentPresenter.paymentData.coupon = nil
                                } else {
                                    couponPresenter.setSelectedCoupon(coupon)
                                    paymentPresenter.paymentData.coupon = coupon
                                }
                            }
                            .border(couponPresenter.selectedCoupon == coupon ? Color.blue : Color.clear, width: 2)
                    }
                }
            }
        }
        .onAppear {
            couponPresenter.fetchcouponDatas() {
                
            }
        }
    }
}


