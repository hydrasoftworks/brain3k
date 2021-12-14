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
        .frame(width: 160, alignment: .leading)
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
            onCommit: checkAndAddTag
        )
        .onReceive(Just(text)) { _ in limitText(16) }
        .focusOnStart()
        .iOS { $0.padding(.vertical, 3) }
        .macOS {
            #if os(macOS)
                $0
                    .padding(.vertical, 1.5)
                    .onExitCommand(perform: exit)
            #endif
        }
    }

    private func checkAndAddTag() {
        let tag = text.trim()
        if !tag.isEmpty { addTag(tag) }
        exit()
    }

    private func exit() {
        text = ""
        withAnimation { editMode = false }
    }

    private func limitText(_ limit: Int) {
        if text.count > limit {
            text = String(text.prefix(limit))
        }
    }
}
