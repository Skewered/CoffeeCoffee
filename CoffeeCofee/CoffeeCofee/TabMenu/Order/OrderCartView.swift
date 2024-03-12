//
//  OrderCartView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/09/07.
//

import SwiftUI

struct OrderCartView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var cartPresenter: OrderCartViewModel

    @State private var totalPriceByShop: [String: Int] = [:]
    
    var body: some View {
        NavigationView {
            List {
                    let groupedCartItems = Dictionary(grouping: cartPresenter.cartItems, by: { $0.shopName })
                    let sortedShopNames = groupedCartItems.keys.sorted()
                    
                    ForEach(sortedShopNames, id: \.self) { shopName in
                        VStack {
                            Text(shopName)
                            NavigationLink(destination: CartDetailView(shopName: shopName)
                                .navigationBarBackButtonHidden(true)
                            )
                                 {
                                Text("주문하기")
                            }
                            
                            OrderCartCell(shopName: shopName)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                        }
                        .onAppear {
                            cartPresenter.fetchTotalPriceByShop(shopName: shopName)
                        }
                        .cornerRadius(10)
                    }
                }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("<")
                    }
                }
            }
        }
        .onAppear {
            cartPresenter.fetchCartItem() {
            }
        }
    }
}
