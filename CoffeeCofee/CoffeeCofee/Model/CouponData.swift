//
//  CouponData.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import Foundation
import SwiftUI

struct CouponData: Hashable, Identifiable {
    
    var id: String
    var publisher: String
    var name: String
    var userId: String
    var date: String
    var discountAmount: Int
    var imageName: String
    var Menuimage: Image{
        Image(imageName)
    }
        
    var couponTapInfo: String?
    
    init(id: String, publisher: String, name: String, userId: String, date: String, discountAmount: Int, imageName: String,  couponTapInfo: String) {
        self.id = id
        self.publisher = publisher
        self.name = name
        self.userId = userId
        self.date = date
        self.imageName = imageName
        self.couponTapInfo = couponTapInfo
        self.discountAmount = discountAmount
    }
}
