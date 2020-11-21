//
//  OffersDataSource.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import Foundation
import UIKit
import Kingfisher

final class OffersDataSource: NSObject, UITableViewDataSource {
    private weak var tableView: UITableView?
    private var offers = [Offer]()
    private let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pl_PL")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        return formatter
    }()

    func attach(tableView: UITableView) {
        tableView.dataSource = self
        self.tableView = tableView
    }

    func update(with offers: [Offer]) {
        self.offers.removeAll(keepingCapacity: true)
        self.offers.append(contentsOf: offers)
        tableView?.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferListCell", for: indexPath) as! OfferListCell
        let offer = offers[indexPath.row]
        cell.titleLabel.text = "\(offer.title)"
        if let price = priceFormatter.number(from: offer.price),
           let priceTitle = priceFormatter.string(from: price) {
            cell.priceLabel.text = "\(priceTitle) PLN"
        } else {
            cell.priceLabel.text = "Gratis!"
        }
        cell.categoryLabel.text = "💰"
        if let url = URL(string: offer.photoUrl) {
            let processor = DownsamplingImageProcessor(size: cell.offerImageView.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            cell.offerImageView.kf.setImage(with: url, options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
            ])
        }

        return cell
    }
}
