//
//  Created by Kamil Powałowski on 31/10/2021.
//

import SwiftUI

struct MemoryCellConnector: View {
    @Environment(\.selectedMemoryID) var selectedMemoryID

    let memory: Memory

    var body: some View {
        Button(
            action: { selectedMemoryID.wrappedValue = memory.id },
            label: { MemoryCell(memory: memory) }
        )
        .memoryCellStyle()
    }
}
