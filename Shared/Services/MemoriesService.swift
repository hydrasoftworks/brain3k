//
//  Created by Kamil Powałowski on 17/07/2021.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class MemoriesService {
    func getAll(for accountId: String) -> AnyPublisher<[Memory], AppError> {
        Future<QuerySnapshot, Error> { [unowned self] promise in
            self.collection(of: accountId)
                .getDocuments(completion: self.handleResponse(promise))
        }
        .map { snapshot -> [Memory] in
            snapshot.documents.compactMap { document in
                try? document.data(as: Memory.self)
            }
        }
        .eraseToAnyPublisher()
        .mapToAppError()
    }

    func add(
        memory: Memory,
        to accountId: String
    ) -> AnyPublisher<Memory, AppError> {
        let collection = collection(of: accountId)
        return Future<DocumentReference, Error> { promise in
            do {
                let documentReference = try collection
                    .addDocument(from: memory)
                promise(.success(documentReference))
            } catch {
                promise(.failure(error))
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
            guard let memory = try document.data(as: Memory.self) else {
                throw AppError(message: "Memory data not found.")
            }
            return memory
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
