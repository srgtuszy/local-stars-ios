//
//  ProfileViewController.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private let fetcher = EntityFetcher()
    private var orders = [Order]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Moje zamówienia"
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        fetchOrders()
    }

    private func fetchOrders() {
        fetcher.fetch(ordersForUserWith: "123") {[weak self] result in
            switch result {
            case .success(let orders):
                self?.orders = orders
                self?.tableView.reloadData()
            case .failure(let error):
                print("Failed to fetch orders: \(error)")
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrderTableViewCell
        let order = orders[indexPath.row]
        cell.statusLabel.text = order.status.title
        cell.fromLabel.text = order.from
        cell.titleLabel.text = order.title

        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension Order.Status {
    var title: String {
        switch self {
        case .received:
            return "Otrzymane ☑️"
        case .inProgress:
            return "W trakcie realizacji 🏗"
        case .inDelivery:
            return "W drodze do Ciebie 🚚"
        case .delivered:
            return "Zrealizowane ✅"
        }
    }
}
