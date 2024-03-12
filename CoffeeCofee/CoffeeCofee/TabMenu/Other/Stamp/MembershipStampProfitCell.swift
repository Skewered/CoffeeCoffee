//
//  MembershipStampProfitCell.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct MembershipStampProfitCell: View {
    var stampDetails: StampDetailsData
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text(stampDetails.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(stampDetails.date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(stampDetails.description)
                .font(.body)
                .foregroundColor(.black)
                .frame(alignment: .trailing)
        }
        .padding(.horizontal, 16)
    }
}
