//
//  Created by Kamil Powałowski on 20/12/2021.
//

import Foundation
import RevenueCat
import SwiftDux

enum SubscriptionAction: Action, Equatable {
    case setOfferings(Offerings)
    case setCustomerInfo(CustomerInfo?)
    case setIsPurchasing(Bool)
}
