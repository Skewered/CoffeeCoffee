//
//  OrderMenuDetailView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/09/02.
//

import SwiftUI

struct OrderMenuDetailView: View {
    var menudata: CoffeeData
    var shopData: ShopData
    
    var body: some View {
       
            VStack {
                menudata.image
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 120.0, height: 120.0)
                    .cornerRadius(5.0)
                
                Text(menudata.name)
                
                OrderMenuDetailOptionView(menudata: menudata, shopData: shopData)
        }
    }
}


