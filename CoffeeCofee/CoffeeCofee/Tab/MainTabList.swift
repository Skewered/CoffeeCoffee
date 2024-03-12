//
//  MainTabList.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/13.
//

import SwiftUI

enum MainTabList {
    case home
    case prepaid
    case order
    case other
    
    var tabTextItem: Text {
        switch self {
        case .home: return Text("홈")
        case .prepaid: return Text("선불카드")
        case .order: return Text("주문")
        case .other: return Text("더보기")
        }
    }
    
    var imageItem: Image {
        switch self {
        case .home: return Image(systemName: "house.fill")
        case .prepaid: return Image(systemName: "creditcard.fill")
        case .order: return Image(systemName: "menucard.fill")
        case .other: return Image(systemName: "questionmark.circle.fill")
        }
    }
}
