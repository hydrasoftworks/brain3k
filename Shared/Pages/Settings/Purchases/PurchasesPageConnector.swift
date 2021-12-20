//
//  Created by Kamil Powałowski on 20/12/2021.
//

import SwiftDux
import SwiftUI

struct PurchasesPageConnector: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state: AppState) -> PurchasesPage.ViewModel? {
        PurchasesPage.ViewModel(
            offerings: state.purchasesState.offerings
        )
    }

    func body(props viewModel: PurchasesPage.ViewModel) -> some View {
        PurchasesPage(viewModel: viewModel)
            .onAppear(dispatch: PurchasesAction.getOfferings())
    }
}
