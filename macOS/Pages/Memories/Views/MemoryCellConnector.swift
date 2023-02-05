//
//  Created by Kamil Powałowski on 31/10/2021.
//

import SwiftDux
import SwiftUI

struct MemoryCellConnector: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch
    @Environment(\.selectedMemoryID) var selectedMemoryID

    let memory: Memory

    func map(state _: AppState) -> MemoryCell.ViewModel? {
        MemoryCell.ViewModel(
            memory: memory,
            delete: { dispatch.send(MemoriesAction.delete(memory: memory)) },
            refresh: { dispatch.send(MemoriesAction.refresh(memory: memory)) },
            report: { dispatch.send(MemoriesAction.report(memory: memory)) }
        )
    }

    func body(props viewModel: MemoryCell.ViewModel) -> some View {
        Button(
            action: { selectedMemoryID.wrappedValue = memory.id },
            label: { MemoryCell(viewModel: viewModel) }
        )
        .memoryCellStyle()
    }
}
