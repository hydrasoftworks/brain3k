//
//  Created by Kamil Powałowski on 20/12/2021.
//

import RevenueCat
import SwiftDux
import SwiftUI

struct SubscriptionsPage: View {
    @Environment(\.presentationMode) private var presentationMode

    let viewModel: ViewModel

    var body: some View {
        ZStack {
            List {
                Section(
                    header: header,
                    footer: footer
                ) {
                    ForEach(viewModel.offering?.availablePackages ?? []) { package in
                        PackageCell(
                            package: package,
                            onSelection: viewModel.purchasePackage
                        )
                    }
                }
            }
            .listStyle(listStyle)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            /// - Display an overlay during a purchase
            Rectangle()
                .foregroundColor(Color.black)
                .opacity(viewModel.isPurchasing ? 0.3 : 0.0)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle(L10n.SubscriptionsPage.title(L10n.appName))
        .toolbar {
            ToolbarItem(placement: cancelButtonPlacement) {
                Button(
                    L10n.General.cancel,
                    role: .cancel,
                    action: { presentationMode.wrappedValue.dismiss() }
                )
            }
        }
        .alert(
            L10n.General.Error.title,
            isPresented: viewModel.$hasPurchaseMessage,
            presenting: viewModel.message,
            actions: { _ in
                Button(L10n.General.ok, role: .cancel, action: {})
            },
            message: { Text($0.text) }
        )
        .onChange(of: viewModel.isSubscriptionActive) { newValue in
            if newValue { presentationMode.wrappedValue.dismiss() }
        }
    }

    private var listStyle: some ListStyle {
        #if os(macOS)
            return InsetListStyle()
        #else
            return InsetGroupedListStyle()
        #endif
    }

    private var header: some View {
        #if os(macOS)
            Text(L10n.SubscriptionsPage.title(L10n.appName))
                .font(.title3)
        #else
            EmptyView()
        #endif
    }

    private var footer: some View {
        VStack {
            footerLine(L10n.SubscriptionsPage.Labels.legal1)
            footerLine(L10n.SubscriptionsPage.Labels.legal2)
            footerLine(L10n.SubscriptionsPage.Labels.legal3)
            footerLine(L10n.SubscriptionsPage.Labels.legal4)
            footerLine(
                L10n.SubscriptionsPage.Labels.legal5(
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
        @ActionBinding var hasPurchaseMessage: Bool
        let message: Message?
        let purchasePackage: (Package) -> Void

        var isSubscriptionActive: Bool { subscription == .pro }

        static func == (lhs: SubscriptionsPage.ViewModel, rhs: SubscriptionsPage.ViewModel) -> Bool {
            lhs.isPurchasing == rhs.isPurchasing
                && lhs.offering == rhs.offering
                && lhs.subscription == rhs.subscription
                && lhs.message == rhs.message
        }
    }
}
