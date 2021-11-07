//
//  Created by Kamil Powałowski on 21/07/2021.
//

import SwiftDux
import SwiftUI

struct MemoryCell: View {
    @Environment(\.colorScheme) private var colorScheme

    let memory: Memory

    var body: some View {
        Group {
            if memory.processed {
                switch memory.type {
                case .url: URLMemoryCellConnector(memory: memory)
                case .image: fatalError()
                }
            } else {
                ProcessingCell()
            }
        }
        .background(
            LinearGradient(
                colors: Color.gradient(colorScheme),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .contentShape(Rectangle())
    }
}
