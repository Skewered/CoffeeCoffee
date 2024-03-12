//
//  HomeUserRecommendView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/12/30.
//

import SwiftUI

struct HomeUserRecommendView: View {
    
    @EnvironmentObject var loginPresenter: LoginViewModel
    @EnvironmentObject var homeUserPresenter: HomeUserViewModel
    
    @Binding var selectedCoffee: CoffeeData?
    @Binding var isPopupCoffeeVisible: Bool
    
    var body: some View {
        VStack {
            Text("\(loginPresenter.userEmail) 님만을 위한 추천음료")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(homeUserPresenter.coffeeData) { coffee in
                        HomeUserMenuView(recommendedCoffee: coffee) { coffee in
                            selectedCoffee = coffee
                            isPopupCoffeeVisible = true
                        }
                    }
                }
            }
        }
    }
}

