//
//  Created by Kamil Powałowski on 17/10/2021.
//

import SwiftDux
import SwiftUI

struct MemoriesPageConnector: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state: AppState) -> MemoriesPage.ViewModel? {
        MemoriesPage.ViewModel(
            memories: state.memoriesState.filtered ?? state.memoriesState.all,
            searchForQuery: { dispatch.send(MemoriesAction.search(for: $0)) },
            getAllMemories: { dispatch.send(MemoriesAction.getAll()) }
        )
    }

    func body(props viewModel: MemoriesPage.ViewModel) -> some View {
        MemoriesPage(viewModel: viewModel)
    }
}
