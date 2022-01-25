//
//  Created by Kamil Powałowski on 21/12/2021.
//

import RevenueCat
import StoreKit

extension Package {
    var period: String {
        if let intro = storeProduct.introductoryPrice {
            if intro.price == 0 {
                return "\(intro.subscriptionPeriod.periodTitle()) free trial"
            } else {
                return "\(localizedIntroductoryPriceString ?? L10n.General.unknown) for \(intro.subscriptionPeriod.periodTitle())"
            }
        } else {
            return storeProduct.subscriptionPeriod?.periodTitle() ?? ""
        }
    }
}

private extension SubscriptionPeriod {
    var durationTitle: String {
        switch unit {
        case .day: return L10n.General.day
        case .week: return L10n.General.week
        case .month: return L10n.General.month
        case .year: return L10n.General.year
        default: return L10n.General.unknown
        }
    }

    func periodTitle() -> String {
        let periodString = "\(value) \(durationTitle)"
        let pluralized = value > 1 ? periodString + "s" : periodString
        return pluralized
    }
}
