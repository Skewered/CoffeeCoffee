//
//  MembershipCouponView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import SwiftUI
import FirebaseAuth

enum CouponTapInfo : String, CaseIterable {
    case have = "보유"
    case download = "다운로드"
    case history = "히스토리"
}


struct MembershipCouponView: View {
    @EnvironmentObject var presenter: MembershipCouponModel
    @State private var selectedPicker: CouponTapInfo = .have


    var body: some View {
        VStack {
            Text("쿠폰")
                .font(.headline)
                .padding()
            
            Picker("Flavor", selection: $selectedPicker) {
                Text("보유 (\(presenter.couponData.filter({ $0.couponTapInfo == "have" }).count))")
                    .tag(CouponTapInfo.have)
                Text("다운로드 (\(presenter.couponData.filter({ $0.couponTapInfo == "download" }).count))")
                    .tag(CouponTapInfo.download)
                Text("히스토리 (\(presenter.couponData.filter({ $0.couponTapInfo == "history" }).count))")
                    .tag(CouponTapInfo.history)
            }
            .pickerStyle(.segmented)
            .padding()
            
            MembershipCouponDetailView(couponTab: selectedPicker)
        }
    }
}
