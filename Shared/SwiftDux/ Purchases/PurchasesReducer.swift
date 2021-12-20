//
//  Created by Kamil Powałowski on 20/12/2021.
//

import SwiftDux

final class PurchasesReducer: Reducer {
    func reduce(
        state: PurchasesState,
        action: PurchasesAction
    ) -> PurchasesState {
        switch action {
        case let .setOfferings(offerings):
            return state.copyWith(offerings: offerings)
        case let .setCustomerInfo(customerInfo):
            if let customerInfo = customerInfo {
                return state.copyWith(customerInfo: customerInfo)
            } else {
                return state.copyWithNil(customerInfo: true)
            }
        }
    }
}
