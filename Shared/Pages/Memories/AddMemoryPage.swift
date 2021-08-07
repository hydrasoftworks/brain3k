//
//  Created by Kamil Powałowski on 27/07/2021.
//

import PartialSheet
import SwiftDux
import SwiftUI
import ValidatedPropertyKit

struct AddMemoryPage: ConnectableView {
    @EnvironmentObject var sheetManager: PartialSheetManager
    @Environment(\.actionDispatcher) private var dispatch

    @Validated(.isURL)
    private var value: String = ""

    func map(state _: AppState) -> ViewModel? {
        ViewModel()
    }

    func body(props _: ViewModel) -> some View {
        VStack(spacing: 16) {
            TextField(L10n.AddMemoryPage.TextField.placeholder, text: $value)
                .styleTextField()
                .keyboardType(.URL)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            PrimaryButton(title: L10n.AddMemoryPage.Button.add) {
                dispatch.send(MemoriesAction.createURL(url: value))
                sheetManager.closePartialSheet()
            }
            .validated(_value)
            .padding(.bottom)
            SecondaryButton(title: L10n.General.cancel) {
                sheetManager.closePartialSheet()
            }
        }
        .padding()
        .padding(.bottom, 32)
    }

    struct ViewModel: Equatable {}
}

struct AddMemoryPage_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoryPage()
    }
}
