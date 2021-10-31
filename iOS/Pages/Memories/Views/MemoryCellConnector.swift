//
//  Created by Kamil Powałowski on 31/10/2021.
//

import SwiftUI

struct MemoryCellConnector: View {
    let memory: Memory

    var body: some View {
        NavigationLink(
            destination: { MemoryPageConnector(memoryId: memory.id) },
            label: { MemoryCell(memory: memory) }
        )
        .memoryCellStyle()
    }
}
