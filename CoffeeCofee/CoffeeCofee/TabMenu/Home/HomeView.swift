//
//  HomeView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct HomeView: View {
   
    @Binding var resetTrigger: Bool
    
    @State var isPopupCoffeeVisible = false
    @State var isPopupBarcodeVisible = false
    @State var selectedCoffee: CoffeeData?
        
    init(resetTrigger: Binding<Bool>) {
        _resetTrigger = resetTrigger
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    HomeEventView()
                    HomeUserNameView()
                    HomeUserCouponView()
                    HomeUserNewsView()
                    HomeUserRecommendView(
                        selectedCoffee: $selectedCoffee,
                        isPopupCoffeeVisible: $isPopupCoffeeVisible
                    )
                }
                .padding()
            }
            .onAppear {
                
                resetTrigger = true

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPopupBarcodeVisible = true
                    }) {
                        Text("바코드")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: HomeUserNoticeView(), label: {
                        Text("알람")
                    })
                }
                
            }
            .overlay(
                HomeUserPopupOverlay(
                    isPopupCoffeeVisible:  $isPopupCoffeeVisible,
                    isPopupBarcodeVisible: $isPopupBarcodeVisible,
                    selectedCoffee: $selectedCoffee)
            )
        }
    }
}
