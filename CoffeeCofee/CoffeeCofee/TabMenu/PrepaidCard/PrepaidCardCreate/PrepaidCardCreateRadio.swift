//
//  PrepaidCardCreateRadio.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct PrepaidCardCreateRadio: View {
    let title: Int
    let isSelected: Bool
    let action: () -> Void

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(action: action) {
            ZStack {
                Capsule()
                    .fill(isSelected ? Color.brown : Color.clear)
                    .overlay(Capsule().stroke(Color.brown, lineWidth: 2))
                    .frame(width: 80, height: 30)
                Text("\(title) 원")
                    .foregroundColor(colorScheme == .light ? .black : .white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

