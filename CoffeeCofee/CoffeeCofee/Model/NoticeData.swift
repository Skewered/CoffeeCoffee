//
//  NoticeData.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import Foundation
import SwiftUI

struct NoticeData: Hashable, Codable, Identifiable {
    
    var id: String
    var userId: String
    var name: String
    var description: String
    
    var date: String
    var dateType: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)
    }
}
