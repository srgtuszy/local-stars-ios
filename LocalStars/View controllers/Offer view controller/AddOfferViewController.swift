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
import FirebaseFirestoreSwift

final class AddOfferViewController: FormViewController {
    private let db = Firestore.firestore()
    private let uploader = ImageUploadService()
    private var photoUrl: String?

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
                    self.pickPhoto()
                }
            }

            <<< ButtonRow() { row in
                row.title = "Wyślij"
                row.onCellSelection {[unowned self] _, _ in
                    self.sendToFirebase()
                }
            }
    }

    private func pickPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true)
    }

    private func sendToFirebase() {
        guard let photoUrl = self.photoUrl else {
            showAlert(title: "Błąd", message: "Potrzebujemy zdjęcia oferty")
            return
        }
        let offer: Offer
        do {
            let title = try form.getValue(for: .title)
            let description = try form.getValue(for: .description)
            let category = try form.getValue(for: .category)
            let price = try form.getValue(for: .price)
            offer = Offer(title: title, description: description, category: category, price: price, photoUrl: photoUrl, merchantId: "1234")
        } catch {
            showAlert(title: "Błąd", message: "Wypełnij wszystkie pola!")
            return
        }
        save(offer: offer)
    }

    private func save(offer: Offer) {
        do {
            try db.collection("offers").document().setData(from: offer)
        } catch {
            print("Failed to save offer: \(error)")
            showAlert(title: "Błąd", message: "Nie udało się dodać oferty, spróbuj jeszcze raz.")
            return
        }
        dismiss(animated: true)
    }

    private func upload(image: UIImage) {
        uploader.upload(image: image) {[weak self] result in
            switch result {
            case .success(let url):
                self?.photoUrl = url
            case .failure(let error):
                print("upload failed: \(error)")
            }
        }
    }
}

extension AddOfferViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        picker.dismiss(animated: true)
        upload(image: image)
    }
}

extension AddOfferViewController: UINavigationControllerDelegate {

}

private extension Form {
    func getValue(for key: String) throws -> String {
        guard let value = values()[key] as? String else {
            throw ParseError.keyNotPresent(key)
        }

        return value
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
