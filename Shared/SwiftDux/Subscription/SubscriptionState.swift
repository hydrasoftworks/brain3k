//
//  Created by Kamil Powałowski on 20/12/2021.
//

import Foundation
import RevenueCat
import SwiftDux

struct SubscriptionState: StateType {
    let isPurchasing: Bool
    let offerings: Offerings?
    let customerInfo: CustomerInfo?

    init(
        isPurchasing: Bool = false,
        offerings: Offerings? = nil,
        customerInfo: CustomerInfo? = nil
    ) {
        self.isPurchasing = isPurchasing
        self.offerings = offerings
        self.customerInfo = customerInfo
    }

    func copyWith(
        isPurchasing: Bool? = nil,
        offerings: Offerings? = nil,
        customerInfo: CustomerInfo? = nil
    ) -> SubscriptionState {
        SubscriptionState(
            isPurchasing: isPurchasing ?? self.isPurchasing,
            offerings: offerings ?? self.offerings,
            customerInfo: customerInfo ?? self.customerInfo
        )
    }

    func copyWithNil(
        customerInfo: Bool = false
    ) -> SubscriptionState {
        SubscriptionState(
            isPurchasing: isPurchasing,
            offerings: offerings,
            customerInfo: customerInfo ? nil : self.customerInfo
        )
    }
}
