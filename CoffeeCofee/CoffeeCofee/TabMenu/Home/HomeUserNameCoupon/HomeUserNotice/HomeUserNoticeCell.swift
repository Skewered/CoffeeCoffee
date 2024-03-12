//
//  HomeUserNoticeCell.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct HomeUserNoticeCell: View {

    var stampDetail: StampDetailsData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(stampDetail.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(8)
                
                Spacer()
                
                Text(stampDetail.date)
                    .font(.subheadline)
            }
            Text(stampDetail.description)
                .font(.body)
                .padding(8)
        }
        .cornerRadius(10)
    }
}
