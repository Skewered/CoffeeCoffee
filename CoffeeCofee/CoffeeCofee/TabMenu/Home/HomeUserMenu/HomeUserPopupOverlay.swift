//
//  HomeUserPopupOverlay.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/12/31.
//

import SwiftUI

struct HomeUserPopupOverlay: View {
    
    @Binding var isPopupCoffeeVisible: Bool
    @Binding var isPopupBarcodeVisible: Bool
    @Binding var selectedCoffee: CoffeeData?
    
    var body: some View {
        ZStack {
            if isPopupCoffeeVisible {
                Color.black.opacity(0.5).ignoresSafeArea()
                    .onTapGesture {
                        isPopupCoffeeVisible = false
                    }
                VStack {
                    if let coffee = selectedCoffee {
                        HomeUserMenuPopup(coffee: coffee, isPopupVisible: $isPopupCoffeeVisible)
                            .frame(width: 300, height: 400)
                            .padding(.horizontal, 35)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            if isPopupBarcodeVisible {
                Color.black.opacity(0.5).ignoresSafeArea()
                    .onTapGesture {
                        isPopupBarcodeVisible = false
                    }
                VStack {
                    HomeUserBarcodePopup(isPopupVisible: $isPopupBarcodeVisible)
                        .frame(width: 300, height: 400)
                        .padding(.horizontal, 35)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}


