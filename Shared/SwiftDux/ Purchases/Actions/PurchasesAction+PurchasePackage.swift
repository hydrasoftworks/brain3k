//
//  Created by Kamil Powałowski on 21/12/2021.
//

import Combine
import RevenueCat
import SwiftDux

extension PurchasesAction {
    static func purchasePackage(
        _ package: Package,
        _ purchasesService: PurchasesService = PurchasesService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            purchasesService.purchasePackage(package)
                .mapToEmptyResult(ofType: Action.self)
                .prepend(PurchasesAction.setIsPurchasing(true))
                .catch { Just(MessageAction.show(.error($0.message))) }
                .append(PurchasesAction.setIsPurchasing(false))
                .eraseToAnyPublisher()
        }
    }
}
