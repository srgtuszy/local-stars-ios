//
//  MerchantsDataSource.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import Foundation
import Kingfisher
import CoreLocation
import UIKit

final class MerchantsDataSource: NSObject, UITableViewDataSource {
    private let locationFetcher = LocationFetcher.default
    private weak var tableView: UITableView?
    private var merchants = [Merchant]()

    func attach(to tableView: UITableView) {
        tableView.dataSource = self
        tableView.rowHeight = 70
        self.tableView = tableView
    }

    func update(with merchants: [Merchant]) {
        self.merchants.removeAll(keepingCapacity: true)
        self.merchants.append(contentsOf: merchants)
        tableView?.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MerchantCell", for: indexPath) as! MerchantCell
        let merchant = merchants[indexPath.row]
        cell.nameLabel.text = merchant.name
        cell.ratingLabel.text = merchant.ratingTitle
        if let url = URL(string: merchant.avatarUrl) {
            cell.avatarImageView.kf.setImage(with: url)
        }
        if let distance = locationFetcher.distance(to: merchant) {
            cell.distanceLabel.text = String(format: "%.2fkm", distance / 1000)
        }

        return cell
    }
}

private extension Merchant {
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }

    var ratingTitle: String {
        var title = ""
        for _ in 0...Int(rating) {
            title += "⭐️ "
        }

        return title
    }
}

private extension LocationFetcher {
    func distance(to merchant: Merchant) -> Double? {
        return currentLocation?.distance(from: merchant.location)
    }
}
