//
//  OrderCartCell.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/09/08.
//

import SwiftUI
import FirebaseAuth

struct OrderCartCell: View {
    
    var shopName: String
    
    @EnvironmentObject var cartPresenter: OrderCartViewModel
    @EnvironmentObject var homeUserPresenter: HomeUserViewModel
    
    var body: some View {
        let cartItemsForShop = cartPresenter.cartItems.filter { $0.shopName == shopName }
        
        ForEach(cartItemsForShop.indices, id: \.self) { index in
            let item = cartItemsForShop[index]
            
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
        .padding()
        
        Text("합계금액 : \(cartPresenter.totalPriceByShop[shopName] ?? 0)")
    }
}

