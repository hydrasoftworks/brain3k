//
//  Created by Kamil Powałowski on 31/10/2021.
//

import SwiftDux
import SwiftUI

struct MemoryCellConnector: View {
    @Environment(\.selectedMemoryID) var selectedMemoryID
    @Environment(\.actionDispatcher) private var dispatch

    let memory: Memory

    var body: some View {
        Button(
            action: { selectedMemoryID.wrappedValue = memory.id },
            label: { MemoryCell(memory: memory) }
        )
        .memoryCellStyle()
    }
}
