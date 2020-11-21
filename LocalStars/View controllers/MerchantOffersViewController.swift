//
//  MerchantOffersViewController.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import UIKit

final class MerchantOffersViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    var merchant: Merchant!
    private let dataSource = OffersDataSource()
    private let offerFetcher = EntityFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = merchant.name
        dataSource.attach(tableView: tableView)
        fetchOffers()
    }

    private func fetchOffers() {
        guard let merchantId = merchant.id else {
            return
        }
        offerFetcher.fetch(offersFromMearchantWith: merchantId) {[weak self] result in
            switch result {
            case .success(let offers):
                self?.dataSource.update(with: offers)
            case .failure(let error):
                print("failed to fetch offers: \(error)")
            }
        }
    }
}
