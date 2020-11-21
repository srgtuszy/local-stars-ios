//
//  CategoryCollectionViewCell.swift
//  LocalStars
//
//  Created by Piotr Tuszynski on 21/11/2020.
//

import Foundation
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var bgImageView: UIImageView!
    @IBOutlet var label: UILabel!
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 15.0
    }
    
}
