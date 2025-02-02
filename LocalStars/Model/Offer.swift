//
//  Offer.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 20/11/2020.
//

import Foundation

struct Offer: Codable {
    var id: String?
    let title: String
    let description: String
    let category: String
    let price: String
    let photoUrl: String
    let merchantId: String
}
