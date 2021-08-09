//
//  Created by Kamil Powałowski on 21/07/2021.
//

import SwiftUI

struct MemoryCell: View {
    @Environment(\.colorScheme) private var colorScheme

    let memory: Memory

    var body: some View {
        content
            .expanded()
            .background(
                LinearGradient(
                    colors: Color.gradient(colorScheme),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .aspectRatio(1, contentMode: .fill)
            .cornerRadius(16)
    }

    @ViewBuilder
    private var content: some View {
        if memory.processed {
            switch memory.type {
            case .url: URLMemoryCell(memory: memory)
            case .image: fatalError()
            }
        } else {
            ProcessingCell()
        }
    }
}

struct MemoryCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoryCell(memory: Memory.exampleURL())
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
