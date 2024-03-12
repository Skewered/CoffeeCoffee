//
//  CartItemData.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/09/08.
//

import SwiftUI

struct CartItemData: Codable, Identifiable {
    
    var id: String
    var userEmail: String
    var selectedCoffee: String
    var price: Int
    var quantity: Int
    var tumbler: String
    var concentration: String
    var userId: String
    var address: String
    var shopName: String
}

