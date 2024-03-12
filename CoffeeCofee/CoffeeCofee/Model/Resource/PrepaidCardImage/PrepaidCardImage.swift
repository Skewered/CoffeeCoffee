//
//  PrepaidCardImage.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

enum PrepaidCardImage: String, CaseIterable, PrepaidCardImageProtocol {
    case image1 = "Bird_PrepaidCardImage1"
    case image2 = "Bird_PrepaidCardImage2"
    case image3 = "Bird_PrepaidCardImage3"
    case image4 = "Bird_PrepaidCardImage4"
    case image5 = "Pattern_PrepaidCardImage1"
    case image6 = "Pattern_PrepaidCardImage2"
    case image7 = "Flower_PrepaidCardImage1"
}
    

protocol PrepaidCardImageProtocol {
    var rawValue: String { get }
}
