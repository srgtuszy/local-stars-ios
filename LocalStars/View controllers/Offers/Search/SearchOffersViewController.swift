//
//  SearchOffersViewController.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import Foundation
import UIKit

final class SearchOffersViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    private let dataSource = OffersDataSource()
    private let fetcher = OffersFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200
        dataSource.attach(tableView: tableView)
    }

    private func search(query: String) {
        fetcher.search(query: query) {[weak self] result in
            switch result {
            case .success(let offers):
                self?.dataSource.update(with: offers)
            case .failure(let error):
                print("search failed: \(error)")
            }
        }
    }
}

extension SearchOffersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else {
            return
        }
        search(query: query)
    }
}
