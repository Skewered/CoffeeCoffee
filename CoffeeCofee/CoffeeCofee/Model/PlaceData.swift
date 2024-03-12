//
//  PlaceData.swift
//  CoffeeCofee
//
//  Created by 1 on 2024/01/26.
//

import SwiftUI

struct PlacesResponse: Decodable {
    let results: [PlaceData]
}

struct PlaceData: Decodable {
    let name: String
    let place_id: String
    let geometry: Geometry
}

struct Geometry: Decodable {
    let location: LocationData
}

struct LocationData: Decodable {
    let lat: Double
    let lng: Double
}

struct PlaceDetailsResponse: Codable {
    let result: PlaceDetails
}

struct PlaceDetails: Codable {
    var name: String
    var formatted_address: String
}
