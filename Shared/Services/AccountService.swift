//
//  Created by Kamil Powałowski on 15/07/2021.
//

import AuthenticationServices
import Combine
import FirebaseAuth
import Foundation

class AccountService {
    func getCurrentAccount() -> Account? {
        if let user = Auth.auth().currentUser {
            return Account(serviceUser: user)
        }
        return nil
    }

    func signUp(email: String, password: String) -> AnyPublisher<Account, AppError> {
        Future<Account, Error> { [weak self] promise in
            Auth.auth().createUser(
                withEmail: email,
                password: password,
                completion: self?.handleSignResponse(promise)
            )
        }
        .mapToAppError()
    }

    func login(credential: ASAuthorizationAppleIDCredential) -> AnyPublisher<Account, AppError> {
        Future<Account, Error> { [weak self] promise in
            guard let appleIDToken = credential.identityToken,
                  let idTokenString = String(data: appleIDToken, encoding: .utf8)
            else {
                let error = AppError(message: "Unable to serialize token string from data: \(String(describing: credential.identityToken))")
                promise(.failure(error))
                return
            }

            let credential = OAuthProvider.credential(
                withProviderID: "apple.com",
                accessToken: idTokenString
            )
            Auth.auth().signIn(
                with: credential,
                completion: self?.handleSignResponse(promise)
            )
        }
        .mapToAppError()
    }

    func login(email: String, password: String) -> AnyPublisher<Account, AppError> {
        Future<Account, Error> { [weak self] promise in
            Auth.auth().signIn(
                withEmail: email,
                password: password,
                completion: self?.handleSignResponse(promise)
            )
        }
        .mapToAppError()
    }

    func signOut() -> AnyPublisher<Void, AppError> {
        Future<Void, Error> { promise in
            do {
                try Auth.auth().signOut()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .mapToAppError()
    }

    func refresh() -> AnyPublisher<Account, AppError> {
        Future<Account, Error> { promise in
            Auth.auth().currentUser?.reload { error in
                if let error = error {
                    promise(.failure(error))
                } else if let user = Auth.auth().currentUser {
                    promise(.success(Account(serviceUser: user)))
                }
            }
        }
        .mapToAppError()
    }

    func sendVerificationEmail() -> AnyPublisher<Void, AppError> {
        Future<Void, Error> { promise in
            Auth.auth().currentUser?.sendEmailVerification { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .mapToAppError()
    }

    private func handleSignResponse(
        _ promise: @escaping Future<Account, Error>.Promise
    ) -> AuthDataResultCallback {
        { result, error in
            if let result = result {
                promise(.success(Account(serviceUser: result.user)))
            } else if let error = error {
                promise(.failure(error))
            }
        }
    }
}
