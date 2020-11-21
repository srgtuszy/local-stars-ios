//
//  OfferDetailsViewController.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import UIKit
import Kingfisher

final class OfferDetailsViewController: UIViewController {
    @IBOutlet private var offerImageView: UIImageView!
    @IBOutlet private var offerTitleLabel: UILabel!
    @IBOutlet private var offerDescriptionLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    var merchant: Merchant!
    var offer: Offer!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }

    private func loadImage() {
        if let url = URL(string: offer.photoUrl) {
            let processor = DownsamplingImageProcessor(size: offerImageView.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            offerImageView.kf.indicatorType = .activity
            offerImageView.kf.setImage(with: url, options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
            ])
        }
    }

    @IBAction @objc private func didTapBuyButton() {

    }
}
