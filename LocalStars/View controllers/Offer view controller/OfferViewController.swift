//
//  OfferViewController.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import UIKit
import Eureka
import FirebaseFirestore

final class OfferViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
    }

    private func configureForm() {
        form +++ Section("Dodaj nową ofertę")
            <<< TextRow() { row in
                row.title = "Tytuł:"
                row.placeholder = "Wpisz tytuł"
            }
            <<< TextRow() { row in
                row.title = "Opis"
                row.placeholder = "Wpisz opis"
            }
            <<< TextRow() { row in
                row.title = "Kategoria"
                row.placeholder = "Wpisz kategorię"
            }
            <<< TextRow() { row in
                row.title = "Cena"
                row.placeholder = "Wpisz cenę"
            }
    }
}
