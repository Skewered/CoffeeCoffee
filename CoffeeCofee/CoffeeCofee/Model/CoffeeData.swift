//
//  CoffeeData.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import Foundation
import SwiftUI

struct CoffeeData: Hashable, Codable, Identifiable {
    
    var id: String
    var name: String
    var category: String
    var nameEng: String
    var state: String
    var coffeeId: String
    var size: String
    var calorie: String
    var description: String
    var allergy: String
    var price: Int
    
    private var imageName: String
    var image: Image{
        Image(imageName)
    }
    
    var nutrient: Nutrient

    struct Nutrient: Hashable, Codable {
        var fat: String
        var sugar: String
        var sodium: String
        var protein: String
        var caffeine: String
    }
    
    init(id: String, name: String, category: String, nameEng: String, state: String, coffeeId: String, size: String, calorie: String, description: String, allergy: String, price: Int, imageName: String, nutrient: Nutrient) {
        self.id = id
        self.name = name
        self.category = category
        self.nameEng = nameEng
        self.state = state
        self.coffeeId = coffeeId
        self.size = size
        self.calorie = calorie
        self.description = description
        self.allergy = allergy
        self.price = price
        self.imageName = imageName
        self.nutrient = nutrient
    }
}
