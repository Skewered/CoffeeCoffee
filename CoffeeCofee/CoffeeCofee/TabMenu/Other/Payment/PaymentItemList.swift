//
//  PaymentItemList.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/11/18.
//

import SwiftUI
import FirebaseAuth

struct PaymentItemList: View {
    
    var shopName: String
    
    @EnvironmentObject var cartPresenter: OrderCartViewModel
    @EnvironmentObject var paymentPresenter: PaymentModel
    @EnvironmentObject var homeUserPresenter: HomeUserViewModel
    
    @State private var cartItemsForShop: [CartItemData] = []
    
    init(shopName: String) {
        self.shopName = shopName
    }
    
    var body: some View {
        VStack {
            ForEach(Array(cartPresenter.cartItemsForShop.enumerated()), id: \.element.id) { index, item in
                if let coffee = homeUserPresenter.coffeeData.first(where: { $0.coffeeId == item.selectedCoffee }) {
                    HStack {
                        coffee.image
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 120.0, height: 120.0)
                            .cornerRadius(5.0)
                        
                        VStack {
                            HStack {
                                Text("(\(coffee.state))")
                                Text(coffee.name)
                            }
                            
                            VStack {
                                Text(item.tumbler)
                                Text(item.concentration)
                            }
                            
                            VStack {
                                Text("\(item.quantity) 개")
                            }
                            
                            HStack {
                                Text("\(item.price) 원")
                            }
                        }
                        
                    }
                } else {
                    Text("해당 메뉴를 찾을 수 없습니다.")
                }
            }
        }
    }
}

