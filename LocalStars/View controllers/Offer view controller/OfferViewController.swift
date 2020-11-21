//
//  OfferViewController.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import UIKit
import Eureka
import Firebase
import FirebaseFirestore

final class OfferViewController: FormViewController {
    private let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
    }

    private func configureForm() {
        form +++ Section("Dodaj nową ofertę")
            <<< TextRow() { row in
                row.title = "Tytuł:"
                row.tag = .title
                row.placeholder = "Wpisz tytuł"
            }
            <<< TextRow() { row in
                row.title = "Opis"
                row.tag = .description
                row.placeholder = "Wpisz opis"
            }
            <<< TextRow() { row in
                row.title = "Kategoria"
                row.tag = .category
                row.placeholder = "Wpisz kategorię"
            }
            <<< TextRow() { row in
                row.title = "Cena"
                row.tag = .price
                row.placeholder = "Wpisz cenę"
            }

            <<< ButtonRow() { row in
                row.title = "Dodaj zdjęcie"
                row.tag = .photo
                row.onCellSelection {[unowned self] _, _ in
                    
                }
            }

            <<< ButtonRow() { row in
                row.title = "Wyślij"
                row.onCellSelection {[unowned self] _, _ in
                    self.sendToFirebase()
                }
            }
    }

    private func sendToFirebase() {
        db.collection("offers").document().setData(form.values())
    }

}

private enum ParseError: Error {
    case keyNotPresent(String)
}

private extension String {
    static let title = "title"
    static let category = "category"
    static let description = "description"
    static let price = "price"
    static let photo = "photo"
}
