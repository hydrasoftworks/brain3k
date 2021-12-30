//
//  Created by Kamil Powałowski on 23/12/2021.
//

import Foundation

extension SettingsPage {
    static let feedbackUrl: URL? = URL(string: "https://shipright.community/brain3k")
    static let writeReviewURL: URL? = URL(string: "https://apps.apple.com/app/id1587505104?action=write-review")
    static let privacyPolicy: URL? = URL(string: "https://brain3k.com/privacy-policy")
    static let termsAndConditions: URL? = URL(string: "https://brain3k.com/terms-and-conditions")
    static let manageSubscriptions: URL? = URL(string: "https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions")

    static func supportUrl(_ email: String?) -> URL? {
        let baseUrl = "https://go.crisp.chat/chat/embed/?website_id=d83eece3-1942-4c5a-9412-219940e99ae3"
        if let email = email {
            return URL(string: "\(baseUrl)&user_email=\(email)")
        }
        return URL(string: baseUrl)
    }

    struct ViewModel: Equatable {
        let accountStatus: AccountStatus
        let email: String?
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
                && lhs.email == rhs.email
                && lhs.memoriesCounter == rhs.memoriesCounter
                && lhs.memoriesLimit == rhs.memoriesLimit
                && lhs.subscription == rhs.subscription
        }
    }
}
