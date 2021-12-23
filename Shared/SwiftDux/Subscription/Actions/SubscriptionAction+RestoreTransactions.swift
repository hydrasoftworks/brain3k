//
//  Created by Kamil Powałowski on 20/12/2021.
//

import Combine
import Foundation
import SwiftDux

extension SubscriptionAction {
    static func restoreTransactions(
        _ subscriptionService: SubscriptionService = SubscriptionService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            subscriptionService.restoreTransactions()
                .map(SubscriptionAction.setCustomerInfo)
                .catch { Just(MessageAction.show(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
