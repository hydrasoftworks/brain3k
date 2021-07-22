//
//  Created by Kamil Powałowski on 22/07/2021.
//

import SwiftUI

struct URLMemoryCell: View {
    let memory: Memory

    var body: some View {
        ZStack(alignment: .bottom) {
            if let url = memory.thumbnailURL {
                image(url)
            } else {
                domain
            }
            if let text = memory.title {
                title(text)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fill)
        .cornerRadius(16)
    }

    private func image(_ url: URL) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            PlaceholderView()
        }
    }

    private var domain: some View {
        let url = memory.valueURL
        return Text(url?.host ?? memory.value)
            .font(.title3)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding()
            .frame(
                minWidth: 0, maxWidth: .infinity,
                minHeight: 0, maxHeight: .infinity
            )
    }

    private func title(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .padding(8)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(.regularMaterial, in: Rectangle())
    }
}

struct URLMemoryCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MemoryCell(
                memory: Memory(
                    objectId: "1",
                    type: .url,
                    value: "https://swiftwombat.com",
                    thumbnail: "https://swiftwombat.com/content/images/2020/12/cover.png",
                    title: "Swift Wombat - Swift & SwiftUI knowledge base"
                )
            )
            .previewLayout(.fixed(width: 200, height: 200))
            MemoryCell(
                memory: Memory(
                    objectId: "1",
                    type: .url,
                    value: "https://swiftwombat.com",
                    title: "Swift Wombat - Swift & SwiftUI knowledge base"
                )
            )
            .previewLayout(.fixed(width: 200, height: 200))
        }
    }
}
