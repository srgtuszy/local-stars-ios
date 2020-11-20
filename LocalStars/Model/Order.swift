//
//  Offer.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 20/11/2020.
//

import Foundation

struct Order {
    let title: String
    let status: Status
    let merchant: Merchant
    let user: User

    enum Status: Int {
        case received
        case inProgress
        case inDelivery
        case delivered
    }
}
