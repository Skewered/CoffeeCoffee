//
//  PrepaidRefundView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct PrepaidRefundView: View {
    @State private var showPrecautions = false
    
    var body: some View {
        VStack {
            HStack {
                Text("전액환불규정")
                Spacer()
                Button(action: {
                    showPrecautions.toggle()
                }) {
                    Image(systemName: showPrecautions ?  "arrow.up" : "arrow.down")
                }
            }
            if showPrecautions {
                Text("""
                1. 첫 번째 환불규정
                2. 두 번째 환불규정
                3. 세 번째 환불규정
                """)
                .padding(.horizontal, 16)
            }
        }
    }
}
