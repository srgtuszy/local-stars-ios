//
//  MerchantOffersViewController.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import UIKit
import SafariServices
import Kingfisher

final class MerchantOffersViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var websiteLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var phoneLabel: UILabel!
    
    var merchant: Merchant!
    private let dataSource = OffersDataSource()
    private let offerFetcher = EntityFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = merchant.name
        dataSource.attach(tableView: tableView)
        nameLabel.text = merchant.name
        ratingLabel.text = merchant.ratingTitle
        websiteLabel.text = merchant.website
        addressLabel.text = merchant.address
        phoneLabel.text = merchant.phone
        configureAvatar()
        fetchOffers()
    }

    @IBAction @objc private func didTapAddress() {
        guard let url = URL(string: "http://maps.apple.com/?ll=\(merchant.latitude),\(merchant.longitude)") else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }

    @IBAction @objc private func didTapPhone() {
        guard let phone = merchant.urlEncodedPhone,
              let url = URL(string: "tel:\(phone)") else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }

    @IBAction @objc private func didTapWebsite() {
        guard let url = URL(string: merchant.website) else {
            return
        }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }

    private func configureAvatar() {
        guard let url = URL(string: merchant.avatarUrl) else {
            return
        }
        let processor = RoundCornerImageProcessor(cornerRadius: 25)
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: url, options: [
            .processor(processor),
            .transition(.fade(1)),
        ])
    }

    private func fetchOffers() {
        guard let merchantId = merchant.id else {
            return
        }
        offerFetcher.fetch(offersFromMearchantWith: merchantId) {[weak self] result in
            switch result {
            case .success(let offers):
                self?.dataSource.update(with: offers)
            case .failure(let error):
                print("failed to fetch offers: \(error)")
            }
        }
    }
}

private extension Merchant {
    var urlEncodedPhone: String? {
        return phone.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
