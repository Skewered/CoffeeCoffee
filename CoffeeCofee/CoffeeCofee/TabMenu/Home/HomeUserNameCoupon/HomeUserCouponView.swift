//
//  HomeUserCouponView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct HomeUserCouponView: View {
    
    var body: some View {
        HStack {
            NavigationLink(destination: MembershipStampView(), label: {
                Image(systemName: "cup.and.saucer")
                Text("스탬프")
            })
            
            NavigationLink(destination: MembershipCouponView(), label: {
                Image(systemName: "ticket")
                Text("쿠폰")
            })
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
        
    }
}
