//
//  Created by Kamil Powałowski on 27/07/2021.
//

import Combine
import SwiftDux
import SwiftUI
import ValidatedPropertyKit

struct AddMemoryPage: ConnectableView {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.actionDispatcher) private var dispatch

    @Validated(.isURL)
    private var value: String = ""

    func map(state: AppState) -> ViewModel? {
        ViewModel(
            canAddMemory: state.accountState.user?.canAddMemory ?? true
        )
    }

    func body(props viewModel: ViewModel) -> some View {
        body(canAddMemory: viewModel.canAddMemory)
            .padding()
            .toolbar {
                ToolbarItem(placement: cancelButtonPlacement) {
                    Button(
                        L10n.General.cancel,
                        role: .cancel,
                        action: { presentationMode.wrappedValue.dismiss() }
                    )
                }
                #if os(macOS)
                    ToolbarItem(placement: .confirmationAction) {
                        Button(L10n.General.add, action: addMemory)
                            .validated(_value)
                    }
                #endif
            }
    }

    @ViewBuilder
    private func body(canAddMemory: Bool) -> some View {
        if canAddMemory {
            form
        } else {
            LimitExceededView()
        }
    }

    private var cancelButtonPlacement: ToolbarItemPlacement {
        #if os(iOS)
            return .automatic
        #else
            return .cancellationAction
        #endif
    }

    private var form: some View {
        VStack(spacing: 16) {
            #if os(macOS)
                Text(L10n.AddMemoryPage.title)
                    .font(.title)
            #endif
            URLTextField(text: $value)
            #if os(iOS)
                PrimaryButton(
                    title: L10n.General.add,
                    action: addMemory
                )
                .validated(_value)
                Spacer()
            #endif
        }
        .navigationTitle(L10n.AddMemoryPage.title)
    }

    private func addMemory() {
        dispatch.send(MemoriesAction.createURL(url: value))
        presentationMode.wrappedValue.dismiss()
    }

    struct ViewModel: Equatable {
        let canAddMemory: Bool
    }
}
