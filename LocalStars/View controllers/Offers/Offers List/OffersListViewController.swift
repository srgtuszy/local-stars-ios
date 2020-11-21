//
//  OffersListViewController.swift
//  LocalStars
//
//  Created by Piotr Tuszynski on 21/11/2020.
//

import Foundation
import UIKit
import Kingfisher

class OffersListViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private let offerFetcher = OffersFetcher()
    private var offers = [Offer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        tableView.dataSource = self
        tableView.rowHeight = 200
        configureOfferUpdates()
    }

    private func configureOfferUpdates() {
        offerFetcher.startUpdatingOffers {[weak self] result in
            switch result {
            case .success(let offers):
                self?.offers.removeAll(keepingCapacity: true)
                self?.offers.append(contentsOf: offers)
                self?.tableView.reloadData()
            case .failure(let error):
                print("Failed to fetch offers: \(error)")
            }
        }
    }
}

extension OffersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferListCell", for: indexPath) as! OfferListCell
        let offer = offers[indexPath.row]
        cell.titleLabel.numberOfLines = 2
        cell.titleLabel.text = "\(offer.title)\nCena: \(offer.price)"
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
