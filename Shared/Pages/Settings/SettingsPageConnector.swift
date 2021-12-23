//
//  Created by Kamil Powałowski on 23/12/2021.
//

import SwiftDux
import SwiftUI

struct SettingsPageConnector: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state: AppState) -> SettingsPage.ViewModel? {
        SettingsPage.ViewModel(
            accountStatus: state.accountState.status,
            memoriesCounter: state.accountState.user?.counter,
            memoriesLimit: state.accountState.user?.limit,
            subscription: state.accountState.user?.subscription,
            onDeleteAccount: { dispatch.send(AccountAction.delete()) },
            onRestoreTransactions: { dispatch.send(PurchasesAction.restoreTransactions()) },
            onSignOut: { dispatch.send(AccountAction.signOut()) }
        )
    }

    func body(props viewModel: SettingsPage.ViewModel) -> some View {
        SettingsPage(viewModel: viewModel)
    }
}
