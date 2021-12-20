//
//  Created by Kamil Powałowski on 20/12/2021.
//

import Foundation
import RevenueCat
import SwiftDux

struct PurchasesState: StateType {
    let offerings: Offerings?
    let customerInfo: CustomerInfo?

    init(
        offerings: Offerings? = nil,
        customerInfo: CustomerInfo? = nil
    ) {
        self.offerings = offerings
        self.customerInfo = customerInfo
    }

    func copyWith(
        offerings: Offerings? = nil,
        customerInfo: CustomerInfo? = nil
    ) -> PurchasesState {
        PurchasesState(
            offerings: offerings ?? self.offerings,
            customerInfo: customerInfo ?? self.customerInfo
        )
    }

    func copyWithNil(
        customerInfo: Bool = false
    ) -> PurchasesState {
        PurchasesState(
            offerings: offerings,
            customerInfo: customerInfo ? nil : self.customerInfo
        )
    }
}
