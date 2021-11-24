//
//  Created by Kamil Powałowski on 17/07/2021.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import Fuse

class MemoriesService {
    func watchAll(for accountId: String) -> AnyPublisher<[Memory], AppError> {
        let collection = collection(of: accountId)
        return AnyPublisher<QuerySnapshot, Error>.create { observer in
            let registration = collection
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
        let collection = collection(of: accountId)
        return Future<QuerySnapshot, Error> { promise in
            collection
                .order(by: "createdAt", descending: true)
                .getDocuments(completion: CompletionHandler(promise).handle())
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

    func update(
        memoryWithId memoryId: String,
        with memory: Memory,
        on accountId: String
    ) -> AnyPublisher<Void, AppError> {
        let document = collection(of: accountId).document(memoryId)
        return Future<Void, Error> { promise in
            do {
                try document.setData(from: memory)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
        .mapToAppError()
    }

    func update(
        memoryWithId memoryId: String,
        withNotes notes: String?,
        on accountId: String
    ) -> AnyPublisher<Void, AppError> {
        let document = collection(of: accountId).document(memoryId)
        return Future<Void, Error> { promise in
            document.updateData([
                "notes": notes ?? FieldValue.delete(),
                "updatedAt": FieldValue.serverTimestamp(),
            ])
            promise(.success(()))
        }
        .eraseToAnyPublisher()
        .mapToAppError()
    }

    func delete(memoryWithId memoryId: String, from accountId: String) -> AnyPublisher<Void, AppError> {
        let document = collection(of: accountId).document(memoryId)
        return Future<Void, Error> { promise in
            document.delete()
            promise(.success(()))
        }
        .eraseToAnyPublisher()
        .mapToAppError()
    }

    func search(for query: String, in memories: [Memory]) -> AnyPublisher<[Memory], AppError> {
        AnyPublisher<[Memory], AppError>.create { observer in
            let fuse = Fuse(threshold: 0.3, tokenize: true)
            fuse.search(query, in: memories) { results in
                let filtered = results.map { memories[$0.index] }
                observer.onNext(filtered)
                observer.onComplete()
            }

            return Disposable {}
        }
    }

    private func collection(of accountId: String) -> CollectionReference {
        Firestore.firestore()
            .collection("users")
            .document(accountId)
            .collection("memories")
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
