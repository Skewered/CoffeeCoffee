//
//  CartDetailCell.swift
//  CoffeeCofee
//
//  Created by 1 on 2024/01/14.
//

import SwiftUI

struct CartDetailCell: View {
    var coffee: CoffeeData
    var item: CartItemData
    
    var body: some View {
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
    }
}

