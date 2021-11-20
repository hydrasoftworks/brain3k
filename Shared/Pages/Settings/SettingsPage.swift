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

    func map(state: AppState) -> ViewModel? {
        ViewModel(
            memoriesCounter: state.accountState.user?.counter,
            memoriesLimit: state.accountState.user?.limit
        )
    }

    func body(props viewModel: ViewModel) -> some View {
        Form {
            subscriptionSection(viewModel)
            accountSection
            linksSection
            signOutSection
        }
        .navigationTitle(L10n.SettingsPage.title)
    }

    private var accountSection: some View {
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
    }

    private func subscriptionSection(_ viewModel: ViewModel) -> some View {
        Section(header: Text(L10n.SettingsPage.Sections.subscription)) {
            if let counter = viewModel.memoriesCounter {
                Text(L10n.SettingsPage.Text.memoriesCurrent(counter))
            }
            if let limit = viewModel.memoriesLimit {
                Text(L10n.SettingsPage.Text.memoriesLimit(limit))
            }
            // TODO: hide if subscription is active
            SecondaryButton(
                title: L10n.SettingsPage.Button.subscribe,
                action: {
                    // TODO: Implement action
                }
            )
            // TODO: hide if subscription is active
            SecondaryButton(
                title: L10n.SettingsPage.Button.restoreSubscription,
                action: {
                    // TODO: Implement action
                }
            )
            // TODO: hide if subscription is not active
            SecondaryButton(
                title: L10n.SettingsPage.Button.manageSubscription,
                action: {
                    openURL(URL(string: "https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions"))
                }
            )
        }
    }

    private var linksSection: some View {
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
    }

    private var signOutSection: some View {
        SecondaryButton(
            title: L10n.SettingsPage.Button.signOut
        ) {
            dispatch.send(AccountAction.signOut())
        }
    }

    private func openURL(_ url: URL?) {
        guard let url = url else { return }
        #if os(iOS)
            UIApplication.shared.open(url)
        #else
            NSWorkspace.shared.open(url)
        #endif
    }

    struct ViewModel: Equatable {
        let memoriesCounter: Int?
        let memoriesLimit: Int?
    }
}