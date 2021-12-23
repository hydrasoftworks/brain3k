//
//  Created by Kamil Powałowski on 20/12/2021.
//

import SwiftDux

final class SubscriptionReducer: Reducer {
    func reduce(
        state: SubscriptionState,
        action: SubscriptionAction
    ) -> SubscriptionState {
        switch action {
        case let .setOfferings(offerings):
            return state.copyWith(offerings: offerings)
        case let .setCustomerInfo(customerInfo):
            if let customerInfo = customerInfo {
                return state.copyWith(customerInfo: customerInfo)
            } else {
                return state.copyWithNil(customerInfo: true)
            }
        case let .setIsPurchasing(isPurchasing):
            return state.copyWith(isPurchasing: isPurchasing)
        }
    }
}
