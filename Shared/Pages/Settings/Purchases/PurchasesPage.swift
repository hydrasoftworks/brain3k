//
//  Created by Kamil Powałowski on 20/12/2021.
//

import RevenueCat
import SwiftUI

struct PurchasesPage: View {
    @Environment(\.presentationMode) private var presentationMode

    let viewModel: ViewModel

    var body: some View {
        Text("Hello, World!")
            .padding()
            .toolbar {
                ToolbarItem(placement: cancelButtonPlacement) {
                    Button(
                        L10n.General.cancel,
                        role: .cancel,
                        action: { presentationMode.wrappedValue.dismiss() }
                    )
                }
            }
    }

    private var cancelButtonPlacement: ToolbarItemPlacement {
        #if os(iOS)
            return .automatic
        #else
            return .cancellationAction
        #endif
    }

    struct ViewModel: Equatable {
        let offerings: Offerings?
    }
}
