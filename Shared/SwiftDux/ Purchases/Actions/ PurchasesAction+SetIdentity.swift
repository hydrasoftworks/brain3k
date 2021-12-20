
//
//  Created by Kamil Powałowski on 20/12/2021.
//

import Combine
import SwiftDux

extension PurchasesAction {
    static func setIdentity(
        _ purchasesService: PurchasesService = PurchasesService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            switch store.state.accountState.status {
            case let .authenticated(account),
                 let .unverifiedEmail(account):
                return purchasesService.signIn(accountId: account.id)
                    .map(PurchasesAction.setCustomerInfo)
                    .catch { Just(MessageAction.show(.error($0.message))) }
                    .eraseToAnyPublisher()
            case .unauthenticated,
                 .undetermined:
                return purchasesService.signOut()
                    .map { _ in PurchasesAction.setCustomerInfo(nil) }
                    .catch { Just(MessageAction.show(.error($0.message))) }
                    .eraseToAnyPublisher()
            }
        }
    }
}
