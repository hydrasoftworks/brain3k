//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftUI

struct SettingsPage: View {
    let viewModel: ViewModel

    var body: some View {
        TabView {
            if viewModel.isAuthenticated {
                Form {
                    SettingsSubscriptionSection(
                        memoriesCounter: viewModel.memoriesCounter,
                        memoriesLimit: viewModel.memoriesLimit,
                        isSubscriptionActive: viewModel.isSubscriptionActive,
                        onRestoreTransactions: viewModel.onRestoreTransactions
                    )
                }
                .tabItem {
                    Label(
                        L10n.SettingsPage.Sections.subscription,
                        systemImage: "star"
                    )
                }
            }
            Form {
                SettingsLinksSection()
            }
            .tabItem {
                Label(
                    L10n.SettingsPage.Sections.links,
                    systemImage: "network"
                )
            }
            if viewModel.isAuthenticated {
                Form {
                    SettingsAccountSection(
                        onDeleteAccount: viewModel.onDeleteAccount,
                        onSignOut: viewModel.onSignOut
                    )
                }
                .tabItem {
                    Label(
                        L10n.SettingsPage.Sections.account,
                        systemImage: "person"
                    )
                }
            }
        }
    }
}
