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
    }
    
    @IBAction func jestemPrzedsiebiorcaTapped() {
        let form = MerchantLoginForm()
        self.navigationController?.pushViewController(form, animated: true)
    }
}

