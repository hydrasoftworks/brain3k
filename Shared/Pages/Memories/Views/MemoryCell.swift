//
//  Created by Kamil Powałowski on 21/07/2021.
//

import SwiftUI

struct MemoryCell: View {
    let memory: Memory

    var body: some View {
        switch memory.type {
        case .url: return URLMemoryCell(memory: memory)
        case .image: fatalError()
        }
    }
}

struct URLMemoryCell: View {
    let memory: Memory

    var body: some View {
        ZStack(alignment: .bottom) {
            if let url = memory.thumbnailURL {
                image(url)
            }
            if let text = memory.title {
                title(text)
            }
        }
        .frame(
            minWidth: 0, maxWidth: .infinity,
            minHeight: 0, maxHeight: .infinity
        )
        .background(Color.red)
        .cornerRadius(16)
    }

    private func image(_ url: URL) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView("Loading...")
        }
    }

    private func title(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(4)
            .background(.regularMaterial, in: Rectangle())
    }
}

struct MemoryCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoryCell(
            memory: Memory(
                objectId: "1",
                type: .url,
                value: "https://swiftwombat.com",
                thumbnail: "https://swiftwombat.com/content/images/2020/12/cover.png",
                title: "Swift Wombat - Swift & SwiftUI knowledge base"
            )
        )
        .previewLayout(.fixed(width: 200, height: 300))
    }
}
