//
//  OtherView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/10/23.
//

import SwiftUI

struct OtherView: View {
    
    @Binding var resetTrigger: Bool
    
    init(resetTrigger: Binding<Bool>) {
        _resetTrigger = resetTrigger

    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                NavigationLink(destination: OrderCartView()
                    .navigationBarBackButtonHidden(true), label: {
                    Text("장바구니")
                })

                NavigationLink(destination: MembershipStampView(), label: {
                    Text("스탬프")
                })

                NavigationLink(destination: MembershipCouponView(), label: {
                    Text("쿠폰")
                })
                
                NavigationLink(destination: HomeUserNoticeView(), label: {
                    Text("알람")
                })
            }
        }
    }
}
