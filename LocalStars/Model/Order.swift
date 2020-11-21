//
//  Offer.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 20/11/2020.
//

import Foundation

struct Order: Codable {
    var id: String?
    let title: String
    let from: String
    let offerId: String
    let merchantId: String
    let userId: String
    let status: Status

    enum Status: Int, Codable {
        case received
        case inProgress
        case inDelivery
        case delivered
    }
}
