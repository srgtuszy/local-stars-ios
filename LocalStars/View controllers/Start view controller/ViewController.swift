//
//  ViewController.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 20/11/2020.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        present(OfferViewController(), animated: false)
    }
    
    @IBAction func jestemPrzedsiebiorcaTapped() {
        let form = NewMerchantForm()
        self.navigationController?.pushViewController(form, animated: true)
    }
}

