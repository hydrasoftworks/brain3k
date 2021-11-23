//
//  Created by Kamil Powałowski on 22/11/2021.
//

import SwiftUI

struct TagsView: View {
    let data = [
        "RoomTime", "AutoWrap", "Talaxy", "FlowLayout", "cold",
        "Swift", "", "SwiftUI", "Overwatch", "Good Days", "back to school",
        "plus",
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text(L10n.MemoryPage.Label.tags)
                .font(.caption)
            AutoWrap(data, id: \.self, vSpacing: 6, hSpacing: 6) { text in
                if text != "plus" {
                    Tag(text: text)
                } else {
                    AddTag()
                }
            }
            .font(.body)
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

private struct Tag: View {
    let text: String

    public var body: some View {
        HStack(spacing: 4) {
            Button(action: {}) {
                Text(text)
                    .fixedSize()
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 0))
                    .contentShape(Rectangle())
            }
            .accessibilityLabel(text)

            Button(action: {}) {
                Label(
                    L10n.MemoryPage.Button.deleteTag,
                    systemImage: "xmark.circle.fill"
                )
                .labelStyle(IconOnlyLabelStyle())
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 4))
                .contentShape(Rectangle())
            }
            .accessibilityLabel(L10n.MemoryPage.Button.deleteTag)
        }
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(Color.brandText)
        .background(Color.brand.opacity(0.7))
        .cornerRadius(4)
    }
}

private struct AddTag: View {
    public var body: some View {
        Button(action: {}) {
            HStack(spacing: 4) {
                Image(systemName: "plus")
                Text(L10n.MemoryPage.Button.addTag)
            }
        }
        .accessibilityLabel(L10n.MemoryPage.Button.addTag)
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(Color.brand.opacity(0.7))
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .cornerRadius(4)
    }
}
