//
//  MerchantsDataSource.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import Foundation
import UIKit

final class MerchantsDataSource: NSObject, UITableViewDataSource {
    private weak var tableView: UITableView?
    private var merchants = [Merchant]()

    func attach(to tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MerchantCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MerchantCell", for: indexPath)
        cell.textLabel?.text = merchants[indexPath.row].name

        return cell
    }
}
