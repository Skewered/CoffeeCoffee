//
//  PaymentCoupon.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/11/20.
//

import SwiftUI

struct PaymentCoupon: View {
    @State private var showPrecautions = false
    
    var body: some View {
        Text("쿠폰 적용")
        
        HStack {
            Text("쿠폰")
            Spacer()
            Button(action: {
                showPrecautions.toggle()
            }) {
                Image(systemName: showPrecautions ?  "arrow.up" : "arrow.down")
            }
        }
        
        if showPrecautions {
            PaymentCouponList()
        }
    }
}

