//
//  MembershipCouponDetailView.swift
//  CoffeeCofee
//
//  Created by 1 on 2024/02/18.
//

import SwiftUI


struct MembershipCouponDetailView: View {
    @EnvironmentObject var presenter: MembershipCouponModel
    @StateObject var loginPresenter = LoginViewModel()

    var couponTab: CouponTapInfo
    
    init(couponTab: CouponTapInfo) {
        self.couponTab = couponTab
    }
    
    var body: some View {
        let userUID = loginPresenter.initializeUserID()

        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                switch couponTab {
                case .have:
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(presenter.couponData.filter({ $0.couponTapInfo == "have" && $0.userId == userUID })) { coupon in
                                MembershipCouponCell(coupon: coupon)
                            }
                        }
                    }
                case .download:
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(presenter.couponData.filter({ $0.couponTapInfo == "download" && $0.userId == userUID })) { coupon in
                                MembershipCouponCell(coupon: coupon)
                            }
                        }
                    }
                case .history:
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(presenter.couponData.filter({ $0.couponTapInfo == "history" && $0.userId == userUID })) { coupon in
                                MembershipCouponCell(coupon: coupon)
                            }
                        }
                    }
                }
            }
        }
    }
}
