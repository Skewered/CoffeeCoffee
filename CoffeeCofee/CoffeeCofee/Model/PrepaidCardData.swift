//
//  PrepaidCardData.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//



import SwiftUI

struct PrepaidCardData: Hashable, Identifiable  {
    var id: String = ""
    var design: String = ""
    var cardName: String = ""
    var chargeAmount: Int = 0
    var paymentMethod: String = ""
    var userId: String = ""
}
