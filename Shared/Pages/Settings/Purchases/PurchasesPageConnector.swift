//
//  Created by Kamil Powałowski on 20/12/2021.
//

import SwiftDux
import SwiftUI

struct PurchasesPageConnector: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state: AppState) -> PurchasesPage.ViewModel? {
        PurchasesPage.ViewModel(
            isPurchasing: state.purchasesState.isPurchasing,
            offering: state.purchasesState.offerings?.current,
            subscription: state.accountState.user?.subscription,
            purchasePackage: { dispatch.send(PurchasesAction.purchasePackage($0)) }
        )
    }

    func body(props viewModel: PurchasesPage.ViewModel) -> some View {
        PurchasesPage(viewModel: viewModel)
            .onAppear(dispatch: PurchasesAction.getOfferings())
    }
}
