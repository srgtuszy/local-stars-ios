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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        present(OfferViewController(), animated: false)
    }
}

