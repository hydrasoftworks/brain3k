//
//  Created by Kamil Powałowski on 23/12/2021.
//

import SwiftUI

struct SettingsAccountSection: View {
    @SwiftUI.State private var isDangerZoneVisible = false
    @SwiftUI.State private var isDeleteAccountConfirmationPresented = false

    let onDeleteAccount: () -> Void
    let onSignOut: () -> Void

    @ViewBuilder
    var body: some View {
        Section(header: header) {
            if isDangerZoneVisible {
                SecondaryButton(
                    title: L10n.SettingsPage.Button.deleteAccount,
                    role: .destructive,
                    action: { isDeleteAccountConfirmationPresented = true }
                )
            } else {
                SecondaryButton(
                    title: L10n.SettingsPage.Button.dangerZone,
                    role: .destructive,
                    action: { isDangerZoneVisible = true }
                )
            }
            SecondaryButton(
                title: L10n.SettingsPage.Button.signOut,
                action: onSignOut
            )
        }
        .confirmationDialog(
            L10n.SettingsPage.Confirmation.deleteAccountTitle,
            isPresented: $isDeleteAccountConfirmationPresented,
            titleVisibility: .visible,
            actions: {
                Button(
                    L10n.SettingsPage.Confirmation.Button.deleteAccount,
                    role: .destructive,
                    action: onDeleteAccount
                )
            }, message: {
                Text(L10n.SettingsPage.Confirmation.deleteAccountMessage)
            }
        )
    }

    private var header: some View {
        #if os(macOS)
            Text(L10n.SettingsPage.Sections.account)
                .font(.title2)
        #else
            Text(L10n.SettingsPage.Sections.account)
        #endif
    }
}
