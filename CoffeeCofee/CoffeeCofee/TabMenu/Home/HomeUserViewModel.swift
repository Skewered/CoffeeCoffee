//
//  HomeUserViewModel.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI
import Firebase


class HomeUserViewModel: ObservableObject {
    
    @Published var coffeeData: [CoffeeData] = []
    @Published var couponData: [CouponData] = []
    @Published var noticeData: [NoticeData] = []
    @Published var selectedCoffee: CoffeeData?
    @Published var isPopupVisible: Bool = false
    @Published var stampData: [StampData] = []
    @Published var stampDetailsData: [StampDetailsData] = []
    @Published var currentIndex = 0
    @Published var autoScrollTimer: Timer?
    @Published var bannerImages: [String] = [
        "image1",
        "image2",
        "image3"
    ]
    
    init() {
        fetchCoffeeData()
    }
    
    func fetchCoffeeData() {
        let db = Database.database().reference()
        
        db.child("CoffeeData").observeSingleEvent(of: .value, with:  { snapshot in
            
            guard let snapshotDict = snapshot.value as? [String: Any] else {
                print("Error: Invalid snapshot format or no data found.")
                return
            }
            
            var coffeeDatas: [CoffeeData] = []
            for (key, value) in snapshotDict {
                
                if  let coffeeDict = value as? [String: Any],
                    let name = coffeeDict["name"] as? String,
                    let category = coffeeDict["category"] as? String,
                    let nameEng = coffeeDict["nameEng"] as? String,
                    let nutrientDict = coffeeDict["nutrient"] as? [String: Any],
                    let fat = nutrientDict["fat"] as? String,
                    let sugar = nutrientDict["sugar"] as? String,
                    let sodium = nutrientDict["sodium"] as? String,
                    let protein = nutrientDict["protein"] as? String,
                    let caffeine = nutrientDict["caffeine"] as? String,
                    let state = coffeeDict["state"] as? String,
                    let coffeeId = coffeeDict["coffeeId"] as? String,
                    let size = coffeeDict["size"] as? String,
                    let calorie = coffeeDict["calorie"] as? String,
                    let description = coffeeDict["description"] as? String,
                    let allergy = coffeeDict["allergy"] as? String,
                    let price = coffeeDict["price"] as? Int,
                    let imageName = coffeeDict["imageName"] as? String {
                    let nutrient = CoffeeData.Nutrient(fat: fat, sugar: sugar, sodium: sodium, protein: protein, caffeine: caffeine)
                    
                    coffeeDatas.append(
                        CoffeeData(
                            id: key,
                            name: name,
                            category: category,
                            nameEng: nameEng,
                            state: state,
                            coffeeId: coffeeId,
                            size: size,
                            calorie: calorie,
                            description: description,
                            allergy: allergy,
                            price: price,
                            imageName: imageName,
                            nutrient: nutrient
                        )
                    )
                }
            }
            self.coffeeData = coffeeDatas
        })
    }
    
    func showPopup(coffee: CoffeeData) {
        self.selectedCoffee = coffee
        self.isPopupVisible = true
    }
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            withAnimation(.linear(duration: 1)) {
                self.currentIndex = (self.currentIndex + 1) % self.bannerImages.count
            }
        }
    }
    
    func startAutoScrollIfNeeded() {
        if autoScrollTimer == nil {
            startAutoScroll()
        }
    }
}
