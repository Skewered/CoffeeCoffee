//
//  MembershipCouponCell.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct MembershipCouponCell: View {
    var coupon: CouponData
    
    var body: some View {
            HStack(alignment: .top) {
                coupon.Menuimage
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 120.0, height: 120.0)
                    .cornerRadius(5.0)
                    .frame(alignment: .leading)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(coupon.publisher)")
                    Text("\(coupon.name)")
                    Text("\(coupon.date)")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}


