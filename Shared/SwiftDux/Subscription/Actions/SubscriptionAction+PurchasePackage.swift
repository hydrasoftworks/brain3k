//
//  Created by Kamil Powałowski on 21/12/2021.
//

import Combine
import RevenueCat
import SwiftDux

extension SubscriptionAction {
    static func purchasePackage(
        _ package: Package,
        _ subscriptionService: SubscriptionService = SubscriptionService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            subscriptionService.purchasePackage(package)
                .mapToEmptyResult(ofType: Action.self)
                .prepend(SubscriptionAction.setIsPurchasing(true))
                .catch { Just(MessageAction.show(.purchase($0.message))) }
                .append(SubscriptionAction.setIsPurchasing(false))
                .eraseToAnyPublisher()
        }
    }
}
