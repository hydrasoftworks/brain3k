//
//  Created by Kamil Powałowski on 27/07/2021.
//

import SwiftDux
import SwiftUI
import ValidatedPropertyKit

struct AddMemoryPage: ConnectableView {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.actionDispatcher) private var dispatch

    @Validated(.isURL)
    private var value: String = ""

    func map(state _: AppState) -> ViewModel? {
        ViewModel()
    }

    func body(props _: ViewModel) -> some View {
        VStack {
            TextField("Paste URL here", text: $value)
                .styleTextField()
                .keyboardType(.URL)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            Spacer()
            PrimaryButton(title: "Add") {
                dispatch.send(MemoriesAction.createURL(url: value))
                presentationMode.wrappedValue.dismiss()
            }
            .validated(_value)
            .padding(.bottom)
            SecondaryButton(title: "Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }

    struct ViewModel: Equatable {}
}

struct AddMemoryPage_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoryPage()
    }
}
