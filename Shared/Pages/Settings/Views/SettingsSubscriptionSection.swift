//
//  Created by Kamil Powałowski on 23/12/2021.
//

import SwiftUI

struct SettingsSubscriptionSection: View {
    @SwiftUI.State private var isPurchasesPresented = false

    let memoriesCounter: Int?
    let memoriesLimit: Int?
    let isSubscriptionActive: Bool
    let onRestoreTransactions: () -> Void

    var body: some View {
        Section(header: Text(L10n.SettingsPage.Sections.subscription)) {
            if let counter = memoriesCounter {
                Text(L10n.SettingsPage.Text.memoriesCurrent(counter))
            }
            if let limit = memoriesLimit {
                Text(L10n.SettingsPage.Text.memoriesLimit(limit))
            }
            if isSubscriptionActive {
                SecondaryButton(
                    title: L10n.SettingsPage.Button.manageSubscription,
                    action: { openURL(SettingsPage.manageSubscriptions) }
                )
            } else {
                SecondaryButton(
                    title: L10n.SettingsPage.Button.subscribe,
                    action: { isPurchasesPresented = true }
                )
                SecondaryButton(
                    title: L10n.SettingsPage.Button.restoreSubscription,
                    action: onRestoreTransactions
                )
            }
        }
        .sheet(
            isPresented: $isPurchasesPresented,
            content: { purchasedPage }
        )
    }

    private var purchasedPage: some View {
        #if os(iOS)
            NavigationView {
                PurchasesPageConnector()
            }
            .accentColor(Color.brand)
        #else
            PurchasesPageConnector()
                .frame(width: 300)
        #endif
    }
}
