//
//  Created by Kamil Powałowski on 20/11/2021.
//

import SwiftUI

struct NotesField: View {
    @State private var editorPresented = false

    let notes: String?
    let updateNotes: (String) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(L10n.MemoryPage.Label.notes)
                .font(.caption)
            Group {
                if let notes = notes, !notes.isEmpty {
                    Text(notes)
                } else {
                    Text(L10n.MemoryPage.Label.notesPlaceholder)
                        .opacity(0.3)
                }
            }
        }
        .font(.body)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .onTapGesture { editorPresented = true }
        .sheet(isPresented: $editorPresented) { editorSheet }
    }

    private var editorSheet: some View {
        #if os(iOS)
            NavigationView { editor }
                .accentColor(Color.brand)
        #else
            editor
                .frame(width: 300)
        #endif
    }

    private var editor: some View {
        NotesEditorPage(
            currentNotes: notes,
            updateNotes: updateNotes
        )
    }
}