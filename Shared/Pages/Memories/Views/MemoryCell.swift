//
//  Created by Kamil Powałowski on 21/07/2021.
//

import SwiftUI

struct MemoryCell: View {
    @Environment(\.colorScheme) private var colorScheme

    let memory: Memory

    var body: some View {
        NavigationLink(
            destination: MemoryPageConnector(memoryId: memory.id)
        ) {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: Color.gradient(colorScheme),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay { content }
        }
        .expanded()
        .aspectRatio(1, contentMode: .fill)
        .cornerRadius(16)
    }

    @ViewBuilder
    private var content: some View {
        if memory.processed {
            switch memory.type {
            case .url: URLMemoryCellConnector(memory: memory)
            case .image: fatalError()
            }
        } else {
            ProcessingCell()
        }
    }
}
