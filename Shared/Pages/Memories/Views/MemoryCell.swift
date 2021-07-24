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

struct MemoryCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoryCell(memory: Memory.exampleURL)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
