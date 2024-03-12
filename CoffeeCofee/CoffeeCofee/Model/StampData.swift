//
//  StampData.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import Foundation
import SwiftUI

struct StampData: Codable, Identifiable {
    
    var id: String
    var userId: String
    var name: String
    var date: String
}
