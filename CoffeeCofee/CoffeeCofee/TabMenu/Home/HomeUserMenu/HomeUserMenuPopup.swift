//
//  HomeUserMenuPopup.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct HomeUserMenuPopup: View {
    var coffee: CoffeeData
    @Binding var isPopupVisible: Bool
    
    var body: some View {
        
        VStack(spacing: 10) {
            coffee.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .padding()
            
            Text(coffee.name)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(coffee.description)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Button(action: {
                isPopupVisible = false
            }) {
                Text("닫기")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .frame(width: 300, height: 40)
            .background(Color.brown)
            .cornerRadius(20)
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
