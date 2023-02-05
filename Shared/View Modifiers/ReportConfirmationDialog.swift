//
//  Created by Kamil Powałowski on 05/02/2023.
//

import SwiftUI

extension View {
    func reportConfirmationDialog(
        isPresented: Binding<Bool>,
        action: @escaping () -> Void
    ) -> some View {
        modifier(
            ReportConfirmationDialog(
                isPresented: isPresented,
                action: action
            )
        )
    }
}

private struct ReportConfirmationDialog: ViewModifier {
    let isPresented: Binding<Bool>
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .confirmationDialog(
                L10n.ReportMemoryConfirmation.reportMemoryTitle,
                isPresented: isPresented,
                titleVisibility: .visible,
                actions: {
                    Button(
                        L10n.ReportMemoryConfirmation.Button.reportMemory,
                        action: {
                            action()
                            HapticService.notificationOccurred(.success)
                        }
                    )
                }, message: {
                    Text(L10n.ReportMemoryConfirmation.reportMemoryMessage)
                }
            )
    }
}
