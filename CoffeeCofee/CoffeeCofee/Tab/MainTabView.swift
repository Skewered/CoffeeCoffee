//
//  MainTabView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/13.
//

import SwiftUI

struct MainTabView: View {
    @Binding var selectedTab: Int
    
    @State private var resetID: Int = 0
    @State private var resetTrigger: Bool = true
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomeView(resetTrigger: $resetTrigger)
                .tabItem{
                    MainTabList.home.imageItem
                    MainTabList.home.tabTextItem
                }
                .id(resetID)
                .tag(0)
            
            PrepaidCardView(resetTrigger: $resetTrigger)
                .tabItem{
                    MainTabList.prepaid.imageItem
                    MainTabList.prepaid.tabTextItem
                }
                .id(resetID)
                .tag(1)

            OrderView(resetTrigger: $resetTrigger)
                .tabItem{
                    MainTabList.order.imageItem
                    MainTabList.order.tabTextItem
                }
                .id(resetID)
                .tag(2)

            OtherView(resetTrigger: $resetTrigger)
                .tabItem{
                    MainTabList.other.imageItem
                    MainTabList.other.tabTextItem
                }
                .id(resetID)
                .tag(3)
        }
        .onChange(of: selectedTab) { _ in
                    resetID += 1
                    resetTrigger.toggle()
        }
    }
}

