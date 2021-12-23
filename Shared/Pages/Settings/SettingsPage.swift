//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct SettingsPage: View {
    let viewModel: ViewModel

    var body: some View {
        Form {
            if viewModel.isAuthenticated {
                SettingsSubscriptionSection(
                    memoriesCounter: viewModel.memoriesCounter,
                    memoriesLimit: viewModel.memoriesLimit,
                    isSubscriptionActive: viewModel.isSubscriptionActive,
                    onRestoreTransactions: viewModel.onRestoreTransactions
                )
            }
            SettingsLinksSection()
            if viewModel.isAuthenticated {
                SettingsAccountSection(
                    onDeleteAccount: viewModel.onDeleteAccount,
                    onSignOut: viewModel.onSignOut
                )
            }
        }
        .navigationTitle(L10n.SettingsPage.title)
    }
}
