//
//  HomeUserMenuView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import SwiftUI

struct HomeUserMenuView: View {
    @EnvironmentObject var homeUserPresenter: HomeUserViewModel

    var recommendedCoffee: CoffeeData
    var onSelect: (CoffeeData) -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    homeUserPresenter.showPopup(coffee: recommendedCoffee)
                    onSelect(recommendedCoffee)
                }) {
                    recommendedCoffee.image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 120.0, height: 120.0)
                        .cornerRadius(5.0)
                }
            }
        }
    }
}


