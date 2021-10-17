//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct SettingsPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch
    @SwiftUI.State private var confirmationIsPresented = false

    func map(state _: AppState) -> ViewModel? {
        ViewModel()
    }

    func body(props _: ViewModel) -> some View {
        Form {
            Section(header: Text(L10n.SettingsPage.Sections.account)) {
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
                        action: { dispatch.send(AccountAction.delete()) }
                    )
                }
            }
            SecondaryButton(
                title: L10n.SettingsPage.Button.signOut
            ) {
                dispatch.send(AccountAction.signOut())
            }
        }

        .navigationTitle(L10n.SettingsPage.title)
    }

    struct ViewModel: Equatable {}
}
