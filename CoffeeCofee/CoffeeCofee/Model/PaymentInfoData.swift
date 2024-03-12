//
//  PaymentInfoData.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/12/05.
//

import Foundation
import SwiftUI

struct PaymentInfoData: Identifiable  {
    var id: String
    var userUID: String
    var cartItems: [CartItemData]
    var shopRequest: String
    var userRequest: String
    var coupon: CouponData?
    var method: String
    var cashreceipt: String
    var cashUserReceipt: String
    var price: Int    
}
