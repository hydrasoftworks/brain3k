//
//  Created by Kamil Powałowski on 23/12/2021.
//

import SwiftUI

struct SettingsAccountSection: View {
    @SwiftUI.State private var confirmationIsPresented = false

    let onDeleteAccount: () -> Void
    let onSignOut: () -> Void

    @ViewBuilder
    var body: some View {
        Section(header: header) {
            SecondaryButton(
                title: L10n.SettingsPage.Button.deleteAccount,
                role: .destructive,
                action: { confirmationIsPresented = true }
            )
            .confirmationDialog(
                L10n.SettingsPage.Confirmation.deleteAccount,
                isPresented: $confirmationIsPresented,
                titleVisibility: .visible
            ) {
                Button(
                    L10n.SettingsPage.Confirmation.Button.deleteAccount,
                    role: .destructive,
                    action: onDeleteAccount
                )
            }
            SecondaryButton(
                title: L10n.SettingsPage.Button.signOut,
                action: onSignOut
            )
        }
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
