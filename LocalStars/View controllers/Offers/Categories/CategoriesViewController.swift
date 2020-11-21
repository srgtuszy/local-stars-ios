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
    
    var model: [[String: String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("HI")
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
