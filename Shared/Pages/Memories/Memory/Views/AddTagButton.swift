//
//  Created by Kamil Powałowski on 13/12/2021.
//

import Combine
import SwiftUI

struct AddTagButton: View {
    @State private var editMode: Bool = false
    @State private var text: String = ""

    let addTag: (String) -> Void

    var body: some View {
        Group {
            if editMode {
                textField
            } else {
                button
            }
        }
    }

    private var button: some View {
        Button(
            action: {
                withAnimation { editMode = true }
            }
        ) {
            HStack(spacing: 4) {
                Image(systemName: "plus")
                Text(L10n.MemoryPage.Button.addTag)
            }
            .padding(.vertical, 4)
            .contentShape(Rectangle())
        }
        .accessibilityLabel(L10n.MemoryPage.Button.addTag)
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(Color.brand.opacity(0.7))
        .fixedSize()
    }

    private var textField: some View {
        TextField(
            L10n.MemoryPage.TextField.addTagPlaceholder,
            text: $text,
            onCommit: handleCommit
        )
        .onReceive(Just(text)) { _ in limitText(16) }
        .focusOnStart()
        .iOS { $0.padding(.vertical, 3) }
        .macOS { $0.padding(.vertical, 1.5) }
    }

    private func handleCommit() {
        let tag = text.trim()
        if !tag.isEmpty { addTag(tag) }
        text = ""
        withAnimation { editMode = false }
    }

    private func limitText(_ limit: Int) {
        if text.count > limit {
            text = String(text.prefix(limit))
        }
    }
}
