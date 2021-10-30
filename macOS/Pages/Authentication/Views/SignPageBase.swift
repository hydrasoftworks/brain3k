//
//  Created by Kamil Powałowski on 16/10/2021.
//

import SwiftUI

struct SignPageBase<FirstSection, SecondSection>: View
    where FirstSection: View, SecondSection: View
{
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
            HStack(spacing: 16) {
                VStack(spacing: 16) { firstSection() }
                VStack(spacing: 16) { secondSection() }
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
}
