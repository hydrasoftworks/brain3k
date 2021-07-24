//
//  Created by Kamil Powałowski on 17/07/2021.
//

import Combine
import FirebaseFirestore

class MemoriesService {
    func getAll(for accountId: String) -> AnyPublisher<[Memory], AppError> {
        Future<QuerySnapshot, Error> { promise in
            Firestore.firestore()
                .collection("users")
                .document(accountId)
                .collection("memories")
                .getDocuments { snapshot, error in
                    if let snapshot = snapshot {
                        promise(.success(snapshot))
                    } else if let error = error {
                        promise(.failure(error))
                    }
                }
        }
        .map { snapshot -> [Memory] in
            snapshot.documents.compactMap { document in
                var data = document.data()
                data["id"] = document.documentID
                return try? DictionaryDecoder().decode(Memory.self, from: data)
            }
        }
        .eraseToAnyPublisher()
        .mapToAppError()
    }
}
