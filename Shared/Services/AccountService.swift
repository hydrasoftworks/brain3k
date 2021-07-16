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

    func signUp(email: String, password: String) -> Future<User, ParseError> {
        User.signupPublisher(username: email, password: password)
    }

    func login(credential: ASAuthorizationAppleIDCredential) -> Future<User, ParseError> {
        User.apple.loginPublisher(
            user: credential.user,
            identityToken: credential.identityToken ?? Data()
        )
    }

    func login(email: String, password: String) -> Future<User, ParseError> {
        User.loginPublisher(username: email, password: password)
    }

    func signOut() -> Future<Void, ParseError> {
        User.logoutPublisher()
    }

    func save(_ user: User) -> Future<User, ParseError> {
        user.savePublisher()
    }

    func refresh(_ user: User) -> Future<User, ParseError> {
        user.fetchPublisher(includeKeys: ["*"])
    }

    func sendVerificationEmail(_ email: String) -> Future<Void, ParseError> {
        User.verificationEmailPublisher(email: email)
    }
}
