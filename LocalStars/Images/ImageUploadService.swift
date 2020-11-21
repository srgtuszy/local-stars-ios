//
//  ImageUploadService.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import Foundation
import UIKit
import Firebase

final class ImageUploadService {
    typealias CompletionBlock = (Result<String, UploadError>) -> Void

    private let storage: Storage
    private let queue = DispatchQueue.global(qos: .userInitiated)

    init(storage: Storage = .storage()) {
        self.storage = storage
    }

    func upload(image: UIImage, completion: @escaping CompletionBlock) {
        queue.async {[weak self] in
            guard let `self` = self, let imageData = image.jpegData(compressionQuality: 80) else {
                completion(.failure(.compressionFailed))
                return
            }
            let imageRef = self.storage.reference().child("images/\(UUID().uuidString).jpg")
            let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, uploadError in
                if let error = uploadError {
                    completion(.failure(.firebaseError(error)))
                    return
                } else if metadata == nil {
                    notify(completion: completion, with: .missingMetadata)
                    return
                }

                imageRef.downloadURL { url, urlError in
                    if let error = urlError {
                        notify(completion: completion, with: .firebaseError(error))
                        return
                    }

                    if let url = url {
                        DispatchQueue.main.async {
                            completion(.success(url.absoluteString))
                        }
                    } else {
                        notify(completion: completion, with: .missingUrl)
                    }
                }
            }
            uploadTask.resume()
        }
    }

    enum UploadError: Error {
        case compressionFailed
        case missingUrl
        case missingMetadata
        case firebaseError(Error)
    }
}

private func notify(completion: @escaping ImageUploadService.CompletionBlock, with error: ImageUploadService.UploadError) {
    DispatchQueue.main.async {
        completion(.failure(error))
    }
}
