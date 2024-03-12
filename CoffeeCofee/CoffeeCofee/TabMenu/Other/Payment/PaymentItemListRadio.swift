//
//  PaymentItemListRadio.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/11/19.
//

import SwiftUI

struct PaymentItemListRadio: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Capsule()
                    .fill(isSelected ? Color.brown : Color.clear)
                    .overlay(Capsule().stroke(Color.brown, lineWidth: 2))
                    .frame(width: 120, height: 30)
                Text("\(title)")
                    .foregroundColor(colorScheme == .light ? .black : .white)
                    .font(.body)
                    .minimumScaleFactor(0.5)
            }
        }
    }
}
