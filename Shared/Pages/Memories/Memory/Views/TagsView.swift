//
//  Created by Kamil Powałowski on 22/11/2021.
//

import SwiftUI

struct TagsView: View {
    private let addTagButtonId: String
    private let tags: [String]

    private let addTag: (String) -> Void
    private let deleteTag: (String) -> Void

    init(
        tags: [String]?,
        addTag: @escaping (String) -> Void,
        deleteTag: @escaping (String) -> Void
    ) {
        addTagButtonId = UUID().uuidString
        self.tags = (tags ?? []) + [addTagButtonId]
        self.addTag = addTag
        self.deleteTag = deleteTag
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(L10n.MemoryPage.Label.tags)
                .font(.caption)
            FlexibleView(
                data: tags,
                spacing: 6,
                alignment: .leading
            ) { tag in
                Group {
                    if tag != addTagButtonId {
                        Tag(
                            text: tag,
                            deleteAction: { deleteTag(tag) }
                        )
                    } else {
                        AddTagButton(addTag: addTag)
                    }
                }
            }
            .font(.body)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

private struct Tag: View {
    let text: String
    let deleteAction: () -> Void

    public var body: some View {
        HStack(spacing: 4) {
            Button(action: {}) {
                Text(text)
                    .fixedSize()
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 0))
                    .contentShape(Rectangle())
            }
            .accessibilityLabel(text)

            Button(action: deleteAction) {
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
