//
//  UIViewController+Alerts.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import UIKit

extension UIViewController {
    func showAlert(title: String? = nil, message: String? = nil, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            action?()
        }))
        present(alert, animated: true)
    }
}
