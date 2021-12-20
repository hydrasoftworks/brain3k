//
//  Created by Kamil Powałowski on 20/12/2021.
//

import Foundation
import RevenueCat
import SwiftDux

enum PurchasesAction: Action, Equatable {
    case setOfferings(Offerings)
    case setCustomerInfo(CustomerInfo?)
}
