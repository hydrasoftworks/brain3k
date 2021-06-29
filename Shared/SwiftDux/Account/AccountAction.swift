//
//  Created by Kamil Powałowski on 29/06/2021.
//

import AuthenticationServices
import Combine
import ParseSwift
import SwiftDux

enum AccountAction: Action {
    case setUser(User?)

    static func signIn(
        _ authorization: ASAuthorization
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store in
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
            User.apple.login(
                user: credential.user,
                identityToken: credential.identityToken ?? Data(),
                completion: { result in
                    switch result {
                    case let .success(user):
                        store.send(AccountAction.setUser(user))
                    case let .failure(error):
                        store.send(AccountAction.setUser(nil))
                        log.error(error)
                    }
                }
            )
        }
    }
}
