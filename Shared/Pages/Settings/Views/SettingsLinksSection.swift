//
//  Created by Kamil Powałowski on 23/12/2021.
//

import SwiftUI

struct SettingsLinksSection: View {
    var body: some View {
        Section(header: header) {
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
                title: L10n.General.Legal.termsAndConditions,
                action: { openURL(SettingsPage.termsAndConditions) }
            )
        }
    }

    private var header: some View {
        #if os(macOS)
            Text(L10n.SettingsPage.Sections.links)
                .font(.title2)
        #else
            Text(L10n.SettingsPage.Sections.links)
        #endif
    }
}
