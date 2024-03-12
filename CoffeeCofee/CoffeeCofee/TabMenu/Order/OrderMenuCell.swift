//
//  OrderMenuCell.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/26.
//

import SwiftUI

struct OrderMenuCell: View {
    
    var menudata: CoffeeData
    var shopData: ShopData
    
    var body: some View {
            VStack {
                NavigationLink(destination: OrderMenuDetailView(menudata: menudata, shopData: shopData)
                    , label: {
                    menudata.image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 120.0, height: 120.0)
                        .cornerRadius(5)
                })
                
                HStack{
                    Text("(\(menudata.state))")
                    Text(menudata.name)
                }
                
                HStack{
                    Text("\(menudata.price) 원")
                }
            }
    }
}
