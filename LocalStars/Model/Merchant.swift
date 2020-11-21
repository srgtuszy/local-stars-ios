//
//  Merchant.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 20/11/2020.
//

import Foundation

struct Merchant: Codable {
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let phone: String
    let email: String
    let category: String
    let rating: Double
    let openingHours: String
    let website: String
}
