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

    func map(state _: AppState) -> ViewModel? {
        ViewModel()
    }

    func body(props _: ViewModel) -> some View {
        VStack(spacing: 16) {
            URLTextField(text: $value)
            PrimaryButton(title: L10n.AddMemoryPage.Button.add) {
                dispatch.send(MemoriesAction.createURL(url: value))
                presentationMode.wrappedValue.dismiss()
            }
            .validated(_value)
            .padding(.bottom)
            SecondaryButton(title: L10n.General.cancel) {
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }
        .padding()
        .padding(.bottom, 32)
        .navigationTitle(L10n.AddMemoryPage.title)
    }

    struct ViewModel: Equatable {}
}
