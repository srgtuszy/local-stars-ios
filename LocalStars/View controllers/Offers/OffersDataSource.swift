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
        cell.priceLabel.text = "\(offer.price)"
        cell.categoryLabel.text = "💰"
        if let url = URL(string: offer.photoUrl) {
            let processor = DownsamplingImageProcessor(size: cell.offerImageView.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            cell.offerImageView.kf.setImage(with: url, options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        }

        return cell
    }
}
