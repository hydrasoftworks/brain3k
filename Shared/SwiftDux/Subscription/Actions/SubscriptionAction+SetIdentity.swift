
//
//  Created by Kamil Powałowski on 20/12/2021.
//

import Combine
import SwiftDux

extension SubscriptionAction {
    static func setIdentity(
        _ subscriptionService: SubscriptionService = SubscriptionService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            switch store.state.accountState.status {
            case let .authenticated(account),
                 let .unverifiedEmail(account):
                return subscriptionService.signIn(accountId: account.id)
                    .map(SubscriptionAction.setCustomerInfo)
                    .catch { Just(MessageAction.show(.error($0.message))) }
                    .eraseToAnyPublisher()
            case .unauthenticated,
                 .undetermined:
                return subscriptionService.signOut()
                    .map { _ in SubscriptionAction.setCustomerInfo(nil) }
                    .catch { Just(MessageAction.show(.error($0.message))) }
                    .eraseToAnyPublisher()
            }
        }
    }
}
