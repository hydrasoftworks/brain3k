//
//  Created by Kamil Powałowski on 20/12/2021.
//

import SwiftDux
import SwiftUI

struct SubscriptionsPageConnector: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state: AppState, binder: ActionBinder) -> SubscriptionsPage.ViewModel? {
        let hasPurchaseMessage: Bool = {
            switch state.messageState.message {
            case .purchase: return true
            case .error,
                 .none:
                return false
            }
        }()

        return SubscriptionsPage.ViewModel(
            isPurchasing: state.subscriptionState.isPurchasing,
            offering: state.subscriptionState.offerings?.current,
            subscription: state.accountState.user?.subscription,
            hasPurchaseMessage: binder.bind(hasPurchaseMessage) { _ in MessageAction.clear },
            message: state.messageState.message,
            purchasePackage: { dispatch.send(SubscriptionAction.purchasePackage($0)) }
        )
    }

    func body(props viewModel: SubscriptionsPage.ViewModel) -> some View {
        SubscriptionsPage(viewModel: viewModel)
            .onAppear(dispatch: SubscriptionAction.getOfferings())
    }
}
