//
//  Created by Kamil Powałowski on 21/07/2021.
//

import SwiftUI

struct MemoryCell: View {
    let memory: Memory

    var body: some View {
        view
            .frame(minWidth: 0, maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fill)
            .cornerRadius(16)
    }

    @ViewBuilder
    private var view: some View {
        if memory.processed {
            switch memory.type {
            case .url: URLMemoryCell(memory: memory)
            case .image: fatalError()
            }
        }
        ProcessingCell()
    }
}

struct MemoryCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoryCell(memory: Memory.exampleURL())
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
