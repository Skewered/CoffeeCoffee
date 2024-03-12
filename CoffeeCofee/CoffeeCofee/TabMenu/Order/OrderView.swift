//
//  OrderView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import SwiftUI


struct OrderView: View {
    
    @Binding var resetTrigger: Bool
    
    @State var showOrderMenuViewPresenter = false
    @State var isOrderMenuViewPresented = false
    @State var shopData = ShopData()
    
    init(resetTrigger: Binding<Bool>) {
        _resetTrigger = resetTrigger
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("지도로 선택")
                    .padding()
                
                OrderMapView(isOrderMenuViewPresented: $isOrderMenuViewPresented, shopData: $shopData)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 300)
                    .alert(isPresented: $isOrderMenuViewPresented) {
                        Alert(title: Text("\(shopData.shopName) 을 선택하셨습니다. 주문하시겠습니까?"), message: nil, primaryButton: .default(Text("예"), action: {
                            showOrderMenuViewPresenter = true
                        }), secondaryButton: .cancel(Text("아니요")))
                    }
                
                NavigationLink(destination: OrderMenuView(shopData: shopData)
                    .navigationBarBackButtonHidden(true)
                    , isActive: $showOrderMenuViewPresenter) { EmptyView() }
            }
        }
    }
}


