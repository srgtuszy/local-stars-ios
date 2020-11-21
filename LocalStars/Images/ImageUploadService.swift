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
    private let storage: Storage
    private let queue = DispatchQueue.global(qos: .userInitiated)
    private var uploadTask: StorageUploadTask?

    init(storage: Storage = .storage()) {
        self.storage = storage
    }

    func upload(image: UIImage, completion: @escaping (Result<String, UploadError>) -> Void) {
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
                    completion(.failure(.missingMetadata))
                    return
                }

                imageRef.downloadURL { url, urlError in
                    if let error = urlError {
                        completion(.failure(.firebaseError(error)))
                        return
                    }

                    if let url = url {
                        DispatchQueue.main.async {
                            completion(.success(url.absoluteString))
                        }
                    } else {
                        completion(.failure(.missingUrl))
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
