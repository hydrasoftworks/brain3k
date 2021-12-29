//
//  Created by Kamil Powałowski on 23/12/2021.
//

import Foundation

extension SettingsPage {
    static let feedbackUrl = URL(string: "https://shipright.community/brain3k")
    static let writeReviewURL = URL(string: "https://apps.apple.com/app/id1587505104?action=write-review")
    static let privacyPolicy = URL(string: "https://brain3k.com/privacy-policy")
    static let termsAndConditions = URL(string: "https://brain3k.com/terms-and-conditions")
    static let manageSubscriptions = URL(string: "https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions")

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
