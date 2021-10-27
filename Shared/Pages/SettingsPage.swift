//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct SettingsPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch
    @SwiftUI.State private var confirmationIsPresented = false

    private let feedbackUrl = URL(string: "https://shipright.community/brain3k")
    private let writeReviewURL = URL(string: "https://apps.apple.com/app/id1587505104?action=write-review")

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
            Section(header: Text(L10n.SettingsPage.Sections.links)) {
                SecondaryButton(
                    title: L10n.SettingsPage.Button.shareFeedback,
                    action: { openURL(feedbackUrl) }
                )
                SecondaryButton(
                    title: L10n.SettingsPage.Button.rate,
                    action: { openURL(writeReviewURL) }
                )
                SecondaryButton(
                    title: L10n.SettingsPage.Button.privacyPolicy,
                    action: {
                        // TODO: Add Privacy policy url
                    }
                )
            }
            SecondaryButton(
                title: L10n.SettingsPage.Button.signOut
            ) {
                dispatch.send(AccountAction.signOut())
            }
        }

        .navigationTitle(L10n.SettingsPage.title)
    }

    func openURL(_ url: URL?) {
        guard let url = url else { return }
        UIApplication.shared.open(url)
    }

    struct ViewModel: Equatable {}
}
