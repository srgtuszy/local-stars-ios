//
//  OfferDetailsViewController.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import UIKit
import Kingfisher
import FirebaseFirestore
import FirebaseFirestoreSwift

final class OfferDetailsViewController: UIViewController {
    @IBOutlet private var offerImageView: UIImageView!
    @IBOutlet private var offerTitleLabel: UILabel!
    @IBOutlet private var offerDescriptionLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    private let db = Firestore.firestore()
    var merchant: Merchant!
    var offer: Offer!

    override func viewDidLoad() {
        super.viewDidLoad()
        offerTitleLabel.text = offer.title
        offerDescriptionLabel.text = offer.description
        addressLabel.text = merchant.address
        loadImage()
    }

    private func loadImage() {
        if let url = URL(string: offer.photoUrl) {
            offerImageView.kf.indicatorType = .activity
            offerImageView.kf.setImage(with: url, options: [
                .transition(.fade(1)),
            ])
        }
    }

    @IBAction @objc private func didTapBuyButton() {
        guard let offerId = offer.id, let merchantId = merchant.id else {
            return
        }
        let order = Order(offerId: offerId, merchantId: merchantId, userId: "123", status: .received)
        do {
            try db.collection("orders").document().setData(from: order)
        } catch {
            showAlert(title: "Błąd", message: "Nie udało się złożyć oferty, spróbuj jeszcze raz")
            return
        }
        showAlert(title: "Sukces", message: "Powiadomiliśmy sprzedającego o Twojej ofercie!", action: {
            self.navigationController?.popViewController(animated: true)
        })
    }
}
