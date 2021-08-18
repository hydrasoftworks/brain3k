//
//  Created by Kamil Powałowski on 17/08/2021.
//

import Combine
import FirebaseStorage
import FirebaseStorageSwift
import Foundation

class StorageService {
    func downloadURL(for storageUrl: URL) -> AnyPublisher<URL, AppError> {
        Future<URL, Error> { promise in
            Storage.storage()
                .reference(forURL: storageUrl.absoluteString)
                .downloadURL(completion: CompletionHandler(promise).handle())
        }
        .eraseToAnyPublisher()
        .mapToAppError()
    }
}
