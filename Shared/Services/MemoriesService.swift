//
//  Created by Kamil Powałowski on 17/07/2021.
//

import Combine
import FirebaseFirestore

class MemoriesService {
    func getAll(for accountId: String) -> AnyPublisher<[Memory], AppError> {
        Future<QuerySnapshot, Error> { [unowned self] promise in
            self.collection(of: accountId)
                .getDocuments(completion: self.handleResponse(promise))
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

    func add(
        type: MemoryType,
        andValue value: String,
        to accountId: String
    ) -> AnyPublisher<Memory, AppError> {
        Future<DocumentReference, Error> { [weak self] promise in
            let documentReference = self?.collection(of: accountId)
                .addDocument(
                    data: [
                        "value": value,
                        "type": type.rawValue,
                        "createdAt": FieldValue.serverTimestamp(),
                        "updatedAt": FieldValue.serverTimestamp(),
                    ],
                    completion: { error in
                        if let error = error { promise(.failure(error)) }
                    }
                )
            if let documentReference = documentReference {
                promise(.success(documentReference))
            }
        }
        .flatMap(getMemory)
        .eraseToAnyPublisher()
        .mapToAppError()
    }

    private func getMemory(_ reference: DocumentReference) -> AnyPublisher<Memory, Error> {
        Future<DocumentSnapshot, Error> { [unowned self] promise in
            reference.getDocument(completion: self.handleResponse(promise))
        }
        .tryMap { document -> Memory in
            guard var data = document.data() else {
                throw AppError(message: "Memory data not found.")
            }
            data["id"] = document.documentID
            return try DictionaryDecoder().decode(Memory.self, from: data)
        }
        .eraseToAnyPublisher()
    }

    private func collection(of accountId: String) -> CollectionReference {
        Firestore.firestore()
            .collection("users")
            .document(accountId)
            .collection("memories")
    }

    private func handleResponse<T>(
        _ promise: @escaping Future<T, Error>.Promise
    ) -> (T?, Error?) -> Void {
        { response, error in
            if let response = response {
                promise(.success(response))
            } else if let error = error {
                promise(.failure(error))
            }
        }
    }
}
