//
//  CategoriesViewController.swift
//  LocalStars
//
//  Created by Piotr Tuszynski on 21/11/2020.
//

import Foundation
import UIKit

class CategoriesViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    private let dataSource = MerchantsDataSource()
    private let merchantFetcher = EntityFetcher()
    
    var model: [[String: String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kategorie"
        tableView.delegate = self
        dataSource.attach(to: tableView)
    }

    private func display(merchantsWithCategory category: String) {
        merchantFetcher.search(merchantsWith: category) {[weak self] result in
            switch result {
            case .success(let merchants):
                self?.dataSource.update(with: merchants)
            case .failure(let error):
                print("failed to fetch merchants: \(error)")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let merchantOffersViewController = segue.destination as! MerchantOffersViewController
        merchantOffersViewController.merchant = (sender as! Merchant)
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showOffers", sender: dataSource.merchants[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]["name"]!
        display(merchantsWithCategory: category)
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.label.text = categories[indexPath.item]["name"]!
        cell.bgImageView.image = UIImage(named: categories[indexPath.item]["image"]!)
        
        return cell
    }
}
