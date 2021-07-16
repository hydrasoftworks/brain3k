//
//  Created by Kamil Powałowski on 29/06/2021.
//

import AuthenticationServices
import Combine
import ParseSwift
import SwiftDux

enum AccountAction: Action, Equatable {
    case setStatus(AccountStatus)

    static func accountAction(for user: User) -> AccountAction {
        if user.emailVerified ?? false {
            return AccountAction.setStatus(.authenticated(user))
        }
        return AccountAction.setStatus(.unverifiedEmail(user))
    }
}
