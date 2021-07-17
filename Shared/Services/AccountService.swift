//
//  Created by Kamil Powałowski on 15/07/2021.
//

import AuthenticationServices
import Combine
import Foundation
import ParseSwift

class AccountService {
    func getCurrentUser() -> User? {
        User.current
    }

    func signUp(email: String, password: String) -> AnyPublisher<User, AppError> {
        User.signupPublisher(username: email, password: password)
            .mapToAppError()
    }

    func login(credential: ASAuthorizationAppleIDCredential) -> AnyPublisher<User, AppError> {
        User.apple.loginPublisher(
            user: credential.user,
            identityToken: credential.identityToken ?? Data()
        )
        .mapToAppError()
    }

    func login(email: String, password: String) -> AnyPublisher<User, AppError> {
        User.loginPublisher(username: email, password: password)
            .mapToAppError()
    }

    func signOut() -> AnyPublisher<Void, AppError> {
        User.logoutPublisher()
            .mapToAppError()
    }

    func save(_ user: User) -> AnyPublisher<User, AppError> {
        user.savePublisher()
            .mapToAppError()
    }

    func refresh(_ user: User) -> AnyPublisher<User, AppError> {
        user.fetchPublisher(includeKeys: ["*"])
            .mapToAppError()
    }

    func sendVerificationEmail(_ email: String) -> AnyPublisher<Void, AppError> {
        User.verificationEmailPublisher(email: email)
            .mapToAppError()
    }
}
