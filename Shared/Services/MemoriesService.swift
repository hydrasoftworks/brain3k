//
//  Created by Kamil Powałowski on 17/07/2021.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class MemoriesService {
    func watchAll(for accountId: String) -> AnyPublisher<[Memory], AppError> {
        AnyPublisher<QuerySnapshot, Error>.create { observer in
            let registration = self.collection(of: accountId)
                .order(by: "createdAt", descending: true)
                .addSnapshotListener { snapshot, error in
                    if let snapshot = snapshot {
                        observer.onNext(snapshot)
                    } else if let error = error {
                        observer.onError(error)
                    }
                }

            return Disposable { registration.remove() }
        }
        .mapToMemories()
    }

    func getAll(for accountId: String) -> AnyPublisher<[Memory], AppError> {
        Future<QuerySnapshot, Error> { [unowned self] promise in
            self.collection(of: accountId)
                .order(by: "createdAt", descending: true)
                .getDocuments(completion: self.handleResponse(promise))
        }
        .eraseToAnyPublisher()
        .mapToMemories()
    }

    func add(memory: Memory, to accountId: String) -> AnyPublisher<Void, AppError> {
        let collection = collection(of: accountId)
        return Future<Void, Error> { promise in
            do {
                _ = try collection.addDocument(from: memory)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
        .mapToAppError()
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

private extension AnyPublisher where Output == QuerySnapshot, Failure == Error {
    func mapToMemories() -> AnyPublisher<[Memory], AppError> {
        map { snapshot -> [Memory] in
            snapshot.documents.compactMap { document in
                try? document.data(as: Memory.self)
            }
        }
        .eraseToAnyPublisher()
        .mapToAppError()
    }
}
