//
//  Created by Kamil Powałowski on 11/11/2021.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class UserService {
    func watch(for accountId: String) -> AnyPublisher<User?, AppError> {
        let document = document(for: accountId)
        return AnyPublisher<DocumentSnapshot, Error>.create { observer in

            let registration = document
                .addSnapshotListener { snapshot, error in
                    if let snapshot = snapshot {
                        observer.onNext(snapshot)
                    } else if let error = error {
                        observer.onError(error)
                    }
                }

            return Disposable { registration.remove() }
        }
        .mapToUser()
    }

    func get(for accountId: String) -> AnyPublisher<User?, AppError> {
        let document = document(for: accountId)
        return Future<DocumentSnapshot, Error> { promise in
            document
                .getDocument(completion: CompletionHandler(promise).handle())
        }
        .eraseToAnyPublisher()
        .mapToUser()
    }

    private func document(for accountId: String) -> DocumentReference {
        Firestore.firestore()
            .collection("users")
            .document(accountId)
    }
}

private extension AnyPublisher where Output == DocumentSnapshot, Failure == Error {
    func mapToUser() -> AnyPublisher<User?, AppError> {
        map { document -> User? in
            try? document.data(as: User.self)
        }
        .eraseToAnyPublisher()
        .mapToAppError()
    }
}
