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

final class EntityFetcher {
    typealias OffersCompletionBlock = (Result<[Offer], FetchError>) -> Void

    private let db: Firestore

    init(db: Firestore = .firestore()) {
        self.db = db
    }

    func startUpdatingOffers(completion: @escaping OffersCompletionBlock) {
        db.collection(.offersCollectionKey)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    completion(.failure(.firebaseError(error)))
                    return
                } else if let snapshot = querySnapshot {
                    let offers = snapshot.documents.compactMap { document -> Offer? in
                        var offer = try? document.data(as: Offer.self)
                        offer?.id = document.documentID

                        return offer
                    }
                    DispatchQueue.main.async {
                        completion(.success(offers))
                    }
                }
            }
    }

    func fetch(offersFromMearchantWith merchantId: String, completion: @escaping OffersCompletionBlock) {
        db.collection(.offersCollectionKey)
            .whereField("merchantId", isEqualTo: merchantId)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    completion(.failure(.firebaseError(error)))
                    return
                } else if let snapshot = querySnapshot {
                    let offers = snapshot.documents.compactMap { document -> Offer? in
                        var offer = try? document.data(as: Offer.self)
                        offer?.id = document.documentID

                        return offer
                    }
                    DispatchQueue.main.async {
                        completion(.success(offers))
                    }
                }

            }
    }

    func search(offersMatching query: String, completion: @escaping OffersCompletionBlock) {
        db.collection(.offersCollectionKey)
            .whereField("title", isGreaterThanOrEqualTo: query)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    completion(.failure(.firebaseError(error)))
                    return
                } else if let snapshot = querySnapshot {
                    let offers = snapshot.documents.compactMap { document -> Offer? in
                        var offer = try? document.data(as: Offer.self)
                        offer?.id = document.documentID

                        return offer
                    }
                    DispatchQueue.main.async {
                        completion(.success(offers))
                    }
                }
            }
    }

    func search(merchantsWith category: String, completion: @escaping (Result<[Merchant], FetchError>) -> Void) {
        db.collection(.merchantCollectionKey)
            .whereField("category", isEqualTo: category)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    completion(.failure(.firebaseError(error)))
                    return
                } else if let snapshot = querySnapshot {
                    let merchants = snapshot.documents.compactMap { (document: QueryDocumentSnapshot) -> Merchant? in
                        var merchant = try? document.data(as: Merchant.self)
                        merchant?.id = document.documentID

                        return merchant
                    }
                    DispatchQueue.main.async {
                        completion(.success(merchants))
                    }
                }
            }
    }

    func fetch(merchantWith merchantId: String, completion: @escaping (Result<Merchant, FetchError>) -> Void) {
        db.collection(.merchantCollectionKey)
            .document(merchantId)
            .getDocument { document, error in
                if let error = error {
                    completion(.failure(.firebaseError(error)))
                } else if let document = document {
                    do {
                        if var merchant = try document.data(as: Merchant.self) {
                            merchant.id = document.documentID
                            completion(.success(merchant))
                        }
                    } catch {
                        completion(.failure(.firebaseError(error)))
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
    static let merchantCollectionKey = "merchants"
}

