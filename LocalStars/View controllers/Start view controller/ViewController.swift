//
//  ViewController.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 20/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var przegladajButton: UIButton!
    @IBOutlet var przedsiebiorcaButton: UIButton!
    @IBOutlet var logowanieButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        przegladajButton.setUnderlinedTitle(string: "Przeglądaj oferty bez logowania")
        przedsiebiorcaButton.setUnderlinedTitle(string: "Jestem przedsiębiorcą")
        logowanieButton.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
    }
    
    @IBAction func jestemPrzedsiebiorcaTapped() {
        let form = MerchantLoginForm()
        self.navigationController?.pushViewController(form, animated: true)
    }
}

extension UIButton {
    func setUnderlinedTitle(string: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12.0),
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
