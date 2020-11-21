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
    private let offerFetcher = EntityFetcher()
    private let dataSource = OffersDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        tableView.rowHeight = 200
        dataSource.attach(tableView: tableView)
        configureOfferUpdates()
    }

    private func configureOfferUpdates() {
        offerFetcher.startUpdatingOffers {[weak self] result in
            switch result {
            case .success(let offers):
                self?.dataSource.update(with: offers)
            case .failure(let error):
                print("Failed to fetch offers: \(error)")
            }
        }
    }
}
