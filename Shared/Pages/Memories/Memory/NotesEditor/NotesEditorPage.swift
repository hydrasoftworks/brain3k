//
//  Created by Kamil Powałowski on 20/11/2021.
//

import SwiftUI

struct NotesEditorPage: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var editedNotes: String

    let updateNotes: (String) -> Void

    init(
        currentNotes: String?,
        updateNotes: @escaping (String) -> Void
    ) {
        _editedNotes = .init(initialValue: currentNotes ?? "")
        self.updateNotes = updateNotes
    }

    var body: some View {
        editor
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
                        Button(
                            L10n.General.save,
                            action: { updateNotes(editedNotes) }
                        )
                    }
                #endif
            }
    }

    private var editor: some View {
        VStack(spacing: 16) {
            #if os(macOS)
                Text(L10n.MemoryPage.Label.notes)
                    .font(.title)
            #endif
            TextEditor(text: $editedNotes)
                .lineLimit(20)
                .font(.body)
            #if os(iOS)
                PrimaryButton(
                    title: L10n.General.save,
                    action: { updateNotes(editedNotes) }
                )
            #endif
        }
        .navigationTitle(L10n.MemoryPage.Label.notes)
    }

    private var cancelButtonPlacement: ToolbarItemPlacement {
        #if os(iOS)
            return .automatic
        #else
            return .cancellationAction
        #endif
    }
}
