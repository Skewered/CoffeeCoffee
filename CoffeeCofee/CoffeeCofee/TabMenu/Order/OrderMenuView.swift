//
//  OrderMenuView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/24.
//
//


import SwiftUI

enum OrderMenuTapInfo : String, CaseIterable {
    case coffee = "커피"
    case smoothie = "스무디"
    case other = "기타"
}

struct OrderMenuView: View {
    @Namespace private var animation
    
    @EnvironmentObject var orderCartViewModel: OrderCartViewModel
    @EnvironmentObject var homeUserPresenter: HomeUserViewModel
    
    @State private var selectedPicker: OrderMenuTapInfo = .coffee
    @State private var isOrderViewPresented = false
    @State private var selectedTab = 2
    @State var shopData: ShopData
    
    var body: some View {
        
        NavigationView {
            VStack {
                orderCartViewModel.OrderAnimate(selectedPicker: $selectedPicker)
                OrderMenuSelectedPickerView(orderTabInfo: selectedPicker, shopData: shopData)
                    .environmentObject(homeUserPresenter)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isOrderViewPresented.toggle()
                    }) {
                        Text("지도 보기")
                    }
                }
                
            }
            .fullScreenCover (isPresented: $isOrderViewPresented, content: {
                MainTabView(selectedTab: $selectedTab)
            })
        }
    }
}


