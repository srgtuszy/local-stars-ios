//
//  OffersFetcher.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

final class OffersFetcher {
    typealias CompletionBlock = (Result<[Offer], FetchError>) -> Void

    private let db: Firestore

    init(db: Firestore = .firestore()) {
        self.db = db
    }

    func startUpdatingOffers(completion: @escaping CompletionBlock) {
        db.collection(.offersCollectionKey)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    completion(.failure(.firebaseError(error)))
                    return
                } else if let snapshot = querySnapshot {
                    let offers = snapshot.documents.compactMap { try? $0.data(as: Offer.self) }
                    DispatchQueue.main.async {
                        completion(.success(offers))
                    }
                }
            }
    }

    func search(query: String, completion: @escaping CompletionBlock) {
        db.collection(.offersCollectionKey)
            .whereField("title", isGreaterThanOrEqualTo: query)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    completion(.failure(.firebaseError(error)))
                    return
                } else if let snapshot = querySnapshot {
                    let offers = snapshot.documents.compactMap { try? $0.data(as: Offer.self) }
                    DispatchQueue.main.async {
                        completion(.success(offers))
                    }
                }
            }
    }

    enum FetchError: Error {
        case firebaseError(Error)
        case missingSnapshot
    }
}

private extension String {
    static let offersCollectionKey = "offers"
}
