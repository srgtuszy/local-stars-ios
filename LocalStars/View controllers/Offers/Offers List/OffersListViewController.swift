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
    private let fetcher = EntityFetcher()
    private let dataSource = OffersDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Oferty"
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        tableView.rowHeight = 200
        tableView.delegate = self
        dataSource.attach(tableView: tableView)
        configureOfferUpdates()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! OfferDetailsViewController
        let (merchant, offer) = sender as! (Merchant, Offer)
        viewController.merchant = merchant
        viewController.offer = offer
    }

    private func configureOfferUpdates() {
        fetcher.startUpdatingOffers {[weak self] result in
            switch result {
            case .success(let offers):
                self?.dataSource.update(with: offers)
            case .failure(let error):
                print("Failed to fetch offers: \(error)")
            }
        }
    }
}

extension OffersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let offer = dataSource.offers[indexPath.row]
        fetcher.fetch(merchantWith: offer.merchantId) {[weak self] result in
            switch result {
            case .success(let merchant):
                self?.performSegue(withIdentifier: "showOffer", sender: (merchant, offer))
            case .failure(let error):
                print("Failed to fetch merchant: \(error)")
            }
        }
    }
}
