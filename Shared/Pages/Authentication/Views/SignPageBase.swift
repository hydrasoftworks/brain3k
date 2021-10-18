//
//  Created by Kamil Powałowski on 16/10/2021.
//

import SwiftUI

struct SignPageBase<FirstSection, SecondSection>: View
    where FirstSection: View, SecondSection: View
{
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    let firstSection: () -> FirstSection
    let secondSection: () -> SecondSection

    init(
        @ViewBuilder firstSection: @escaping () -> FirstSection,
        @ViewBuilder secondSection: @escaping () -> SecondSection
    ) {
        self.firstSection = firstSection
        self.secondSection = secondSection
    }

    var body: some View {
        Group {
            if verticalSizeClass == .regular {
                portrait
            } else if verticalSizeClass == .compact {
                landscape
            }
        }
        .multilineTextAlignment(.center)
        .padding()
        .materialBackground()
        .padding()
    }

    private var portrait: some View {
        VStack(spacing: 16) {
            firstSection()
            secondSection()
        }
    }

    private var landscape: some View {
        HStack(spacing: 16) {
            VStack(spacing: 16) { firstSection() }
            VStack(spacing: 16) { secondSection() }
        }
    }
}
