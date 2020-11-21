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
    private let fetcher = EntityFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Szukaj"
        tableView.rowHeight = 200
        tableView.delegate = self
        dataSource.attach(tableView: tableView)
    }

    private func search(query: String) {
        fetcher.search(offersMatching: query) {[weak self] result in
            switch result {
            case .success(let offers):
                self?.dataSource.update(with: offers)
            case .failure(let error):
                print("search failed: \(error)")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! OfferDetailsViewController
        let (merchant, offer) = sender as! (Merchant, Offer)
        viewController.merchant = merchant
        viewController.offer = offer
    }
}

extension SearchOffersViewController: UITableViewDelegate {
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

extension SearchOffersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text, !query.isEmpty else {
            return
        }
        search(query: query)
    }
}
