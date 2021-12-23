//
//  Created by Kamil Powałowski on 23/12/2021.
//

import SwiftUI

struct SettingsSubscriptionSection: View {
    @SwiftUI.State private var isSubscriptionsPresented = false

    let memoriesCounter: Int?
    let memoriesLimit: Int?
    let isSubscriptionActive: Bool
    let onRestoreTransactions: () -> Void

    var body: some View {
        Section(header: header) {
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
                    action: { isSubscriptionsPresented = true }
                )
                SecondaryButton(
                    title: L10n.SettingsPage.Button.restoreSubscription,
                    action: onRestoreTransactions
                )
            }
        }
        .sheet(
            isPresented: $isSubscriptionsPresented,
            content: { subscriptionsPage }
        )
    }

    private var subscriptionsPage: some View {
        #if os(iOS)
            NavigationView {
                SubscriptionsPageConnector()
            }
            .accentColor(Color.brand)
        #else
            SubscriptionsPageConnector()
                .frame(width: 360, height: 360)
        #endif
    }

    private var header: some View {
        #if os(macOS)
            Text(L10n.SettingsPage.Sections.subscription)
                .font(.title2)
        #else
            Text(L10n.SettingsPage.Sections.subscription)
        #endif
    }
}
