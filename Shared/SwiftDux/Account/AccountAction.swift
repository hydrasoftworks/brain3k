//
//  Created by Kamil Powałowski on 29/06/2021.
//

import AuthenticationServices
import Combine
import ParseSwift
import SwiftDux

enum AccountAction: Action {
    case setStatus(AccountStatus)
}

extension AccountAction {
    static func checkAccountStatus() -> ActionPlan<AppState> {
        ActionPlan<AppState> { store in
            let status: AccountStatus
            if let user = User.current {
                if user.emailVerified ?? false {
                    status = .authenticated(user)
                } else {
                    status = .unverifiedEmail(user)
                }
            } else {
                status = .unauthenticated
            }
            store.send(AccountAction.setStatus(status))
        }
    }

    static func signIn(
        _ authorization: ASAuthorization
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                return .empty
            }

            return User.apple.loginPublisher(
                user: credential.user,
                identityToken: credential.identityToken ?? Data()
            )
            .map { user in AccountAction.setStatus(.authenticated(user)) }
            .catch { Just(MessageAction.set(Message.error($0.message))) }
            .eraseToAnyPublisher()
        }
    }

    static func signIn(
        withEmail email: String,
        andPassword password: String
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            User.loginPublisher(username: email, password: password)
                .map { user in
                    if user.emailVerified ?? false {
                        return AccountAction.setStatus(.authenticated(user))
                    }
                    return AccountAction.setStatus(.unverifiedEmail(user))
                }
                .catch { Just(MessageAction.set(Message.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }

    static func signUp(
        withEmail email: String,
        andPassword password: String
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            User.signupPublisher(username: email, password: password)
                .flatMap { user -> AnyPublisher<User, ParseError> in
                    var user = user
                    user.email = email
                    return user.savePublisher()
                        .map { _ in user }
                        .eraseToAnyPublisher()
                }
                .map { user in AccountAction.setStatus(.unverifiedEmail(user)) }
                .catch { Just(MessageAction.set(Message.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }

    static func signOut() -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            User.logoutPublisher()
                .map { AccountAction.setStatus(.unauthenticated) }
                .catch { Just(MessageAction.set(Message.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }

    static func refresh() -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard let user = store.state.account.user else {
                return .empty
            }

            return user
                .fetchPublisher(includeKeys: ["*"])
                .map { user in
                    if user.emailVerified ?? false {
                        return AccountAction.setStatus(.authenticated(user))
                    }
                    return AccountAction.setStatus(.unverifiedEmail(user))
                }
                .catch { Just(MessageAction.set(Message.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }

    static func sendVerificationEmail() -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard let email = store.state.account.user?.email else {
                return .empty
            }

            return User.verificationEmailPublisher(email: email)
                .mapToEmptyResult(ofType: Action.self)
                .catch { Just(MessageAction.set(Message.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
