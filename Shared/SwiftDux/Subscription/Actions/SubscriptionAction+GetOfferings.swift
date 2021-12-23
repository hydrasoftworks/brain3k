//
//  Created by Kamil Powałowski on 20/12/2021.
//

import Combine
import Foundation
import SwiftDux

extension SubscriptionAction {
    static func getOfferings(
        _ subscriptionService: SubscriptionService = SubscriptionService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            subscriptionService.getOfferings()
                .map(SubscriptionAction.setOfferings)
                .catch { Just(MessageAction.show(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
