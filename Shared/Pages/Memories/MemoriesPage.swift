//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct MemoriesPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    @SwiftUI.State private var isAddMemoryPresented: Bool = false

    func map(state: AppState, binder: ActionBinder) -> ViewModel? {
        ViewModel(
            memories: state.memoriesState.filtered ?? state.memoriesState.all,
            searchQuery: binder.bind(state.memoriesState.searchQuery) {
                MemoriesAction.search(for: $0)
            }
        )
    }

    func body(props viewModel: ViewModel) -> some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 150), spacing: 16)],
                spacing: 16
            ) {
                ForEach(viewModel.memories) { memory in
                    NavigationLink(
                        destination: MemoryPageConnector(memoryId: memory.id)
                    ) {
                        MemoryCell(memory: memory)
                    }
                }
            }
            .padding(.horizontal)
        }
        // Pull to Refresh doesn't work on ScrollView xD
        .refreshable { dispatch.send(MemoriesAction.getAll()) }
        .searchable(text: viewModel.$searchQuery)
        .navigationTitle(L10n.MemoriesPage.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { isAddMemoryPresented.toggle() }) {
                    Label(L10n.MemoriesPage.Button.add, systemImage: "plus")
                }
            }
        }
        .sheet(
            isPresented: $isAddMemoryPresented,
            content: { NavigationView { AddMemoryPage() } }
        )
    }

    struct ViewModel: Equatable {
        let memories: [Memory]
        @ActionBinding var searchQuery: String
    }
}

struct BrowseMemoriesPage_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesPage()
    }
}