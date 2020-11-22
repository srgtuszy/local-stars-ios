//
//  File.swift
//  LocalStars
//
//  Created by Piotr Tuszynski on 22/11/2020.
//

import Foundation
import UIKit

class MerchantAdminViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let dataSource = OffersDataSource()
    private let offerFetcher = EntityFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.attach(tableView: tableView)
        fetchOffers()
    }

    private func fetchOffers() {
        offerFetcher.fetch(offersFromMearchantWith: .merchantId) {[weak self] result in
            switch result {
            case .success(let offers):
                self?.dataSource.update(with: offers)
            case .failure(let error):
                print("failed to fetch offers: \(error)")
            }
        }
    }
}

private extension String {
    static let merchantId = "rBabB8LvKR0VPJcQBA0o"
}
