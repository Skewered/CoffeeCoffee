//
//  OrderMenuSelectedPickerView.swift
//  CoffeeCofee
//
//  Created by 1 on 2024/02/15.
//

import SwiftUI

struct OrderMenuSelectedPickerView: View {
    @EnvironmentObject var homeUserPresenter: HomeUserViewModel
    @EnvironmentObject var orderCartViewModel: OrderCartViewModel
    
    var orderTabInfo: OrderMenuTapInfo
    var shopData: ShopData
    
    init(orderTabInfo: OrderMenuTapInfo, shopData: ShopData) {
        self.orderTabInfo = orderTabInfo
        self.shopData = shopData
    }
    
    var body: some View {
        VStack {
            switch orderTabInfo {
            case .coffee:
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                            ForEach(homeUserPresenter.coffeeData.filter { $0.category == "Coffee" }, id: \.id) { menu in
                                HStack(alignment: .top) {
                                    
                                    OrderMenuCell(menudata: menu, shopData: shopData)
                                    Spacer()
                                }
                            }
                        }
                        .padding()
                    }
                }
            case .smoothie:
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                            ForEach(homeUserPresenter.coffeeData.filter { $0.category == "Smoothie" }, id: \.id) { menu in
                                HStack(alignment: .top) {
                                    OrderMenuCell(menudata: menu, shopData: shopData)
                                    Spacer()
                                }
                            }
                        }
                        .padding()
                    }
                }
            case .other:
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                            ForEach(homeUserPresenter.coffeeData.filter { $0.category != "Coffee" && $0.category != "Smoothie" }, id: \.id) { menu in
                                HStack(alignment: .top) {
                                    OrderMenuCell(menudata: menu, shopData: shopData)
                                    Spacer()
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

