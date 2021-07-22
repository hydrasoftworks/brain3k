//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct MemoriesPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state: AppState) -> ViewModel? {
        ViewModel(memories: state.memoriesState.values)
    }

    @ViewBuilder
    func body(props viewModel: ViewModel) -> some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 150), spacing: 16)],
                spacing: 16
            ) {
                ForEach(viewModel.memories) { memory in
                    MemoryCell(memory: memory)
                }
            }
        }
        .padding(.horizontal)
        .refreshable { dispatch.send(MemoriesAction.getAll()) }
        .onAppear(dispatch: MemoriesAction.getAll())
    }

    struct ViewModel: Equatable {
        let memories: [Memory]
    }
}

struct BrowseMemoriesPage_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesPage()
    }
}
