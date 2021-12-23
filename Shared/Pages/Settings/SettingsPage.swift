//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct SettingsPage: View {
    @SwiftUI.State private var confirmationIsPresented = false
    @SwiftUI.State private var isPurchasesPresented = false

    static let feedbackUrl = URL(string: "https://shipright.community/brain3k")
    static let writeReviewURL = URL(string: "https://apps.apple.com/app/id1587505104?action=write-review")
    static let privacyPolicy = URL(string: "https://brain3k.com/privacy-policy")
    static let termsOfUse = URL(string: "https://brain3k.com/terms-of-use")
    static let manageSubscriptions = URL(string: "https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions")

    let viewModel: ViewModel

    var body: some View {
        Form {
            if viewModel.isAuthenticated {
                subscriptionSection(viewModel)
                accountSection
            }
            linksSection
            if viewModel.isAuthenticated {
                signOutSection
            }
        }
        .navigationTitle(L10n.SettingsPage.title)
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
                    action: viewModel.onDeleteAccount
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
            if viewModel.isSubscriptionActive {
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
                    action: viewModel.onRestoreTransactions
                )
            }
        }
    }

    private var linksSection: some View {
        Section(header: Text(L10n.SettingsPage.Sections.links)) {
            SecondaryButton(
                title: L10n.SettingsPage.Button.shareFeedback,
                action: { openURL(SettingsPage.feedbackUrl) }
            )
            SecondaryButton(
                title: L10n.SettingsPage.Button.rate,
                action: { openURL(SettingsPage.writeReviewURL) }
            )
            SecondaryButton(
                title: L10n.General.Legal.privacyPolicy,
                action: { openURL(SettingsPage.privacyPolicy) }
            )
            SecondaryButton(
                title: L10n.General.Legal.termsOfUse,
                action: { openURL(SettingsPage.termsOfUse) }
            )
        }
    }

    private var signOutSection: some View {
        SecondaryButton(
            title: L10n.SettingsPage.Button.signOut,
            action: viewModel.onSignOut
        )
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
        let accountStatus: AccountStatus
        let memoriesCounter: Int?
        let memoriesLimit: Int?
        let subscription: Subscription?

        let onDeleteAccount: () -> Void
        let onRestoreTransactions: () -> Void
        let onSignOut: () -> Void

        var isAuthenticated: Bool {
            switch accountStatus {
            case .authenticated:
                return true
            case .unverifiedEmail,
                 .unauthenticated,
                 .undetermined:
                return false
            }
        }

        var isSubscriptionActive: Bool { subscription == .pro }

        static func == (lhs: SettingsPage.ViewModel, rhs: SettingsPage.ViewModel) -> Bool {
            lhs.accountStatus == rhs.accountStatus
                && lhs.memoriesCounter == rhs.memoriesCounter
                && lhs.memoriesLimit == rhs.memoriesLimit
                && lhs.subscription == rhs.subscription
        }
    }
}
