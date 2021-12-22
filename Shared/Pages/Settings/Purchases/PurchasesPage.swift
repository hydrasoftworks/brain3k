//
//  Created by Kamil Powałowski on 20/12/2021.
//

import RevenueCat
import SwiftUI

struct PurchasesPage: View {
    @Environment(\.presentationMode) private var presentationMode

    let viewModel: ViewModel

    var body: some View {
        ZStack {
            List {
                Section(footer: footer) {
                    ForEach(viewModel.offering?.availablePackages ?? []) { package in
                        PackageCell(
                            package: package,
                            onSelection: viewModel.purchasePackage
                        )
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            /// - Display an overlay during a purchase
            Rectangle()
                .foregroundColor(Color.black)
                .opacity(viewModel.isPurchasing ? 0.5 : 0.0)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationBarTitle(L10n.PurchasesPage.title(L10n.appName))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: cancelButtonPlacement) {
                Button(
                    L10n.General.cancel,
                    role: .cancel,
                    action: { presentationMode.wrappedValue.dismiss() }
                )
            }
        }
        .onChange(of: viewModel.isSubscriptionActive) { newValue in
            if newValue { presentationMode.wrappedValue.dismiss() }
        }
    }

    private var footer: some View {
        VStack {
            footerLine(L10n.PurchasesPage.Labels.legal1)
            footerLine(L10n.PurchasesPage.Labels.legal2)
            footerLine(L10n.PurchasesPage.Labels.legal3)
            footerLine(L10n.PurchasesPage.Labels.legal4)
            footerLine(
                L10n.PurchasesPage.Labels.legal5(
                    SettingsPage.privacyPolicy?.absoluteString ?? "",
                    SettingsPage.termsOfUse?.absoluteString ?? ""
                )
            )
        }
        .font(.caption2)
    }

    private var cancelButtonPlacement: ToolbarItemPlacement {
        #if os(iOS)
            return .automatic
        #else
            return .cancellationAction
        #endif
    }

    private func footerLine(_ text: String) -> some View {
        Text((try? AttributedString(markdown: text)) ?? AttributedString(text))
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }

    struct ViewModel: Equatable {
        let isPurchasing: Bool
        let offering: Offering?
        let subscription: Subscription?
        let purchasePackage: (Package) -> Void

        var isSubscriptionActive: Bool { subscription == .pro }

        static func == (lhs: PurchasesPage.ViewModel, rhs: PurchasesPage.ViewModel) -> Bool {
            lhs.isPurchasing == rhs.isPurchasing
                && lhs.offering == rhs.offering
                && lhs.subscription == rhs.subscription
        }
    }
}
