//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct MemoriesPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    @SwiftUI.State private var searchQuery: String = ""
    @SwiftUI.State private var isAddMemoryPresented: Bool = false

    func map(state: AppState) -> ViewModel? {
        ViewModel(memories: state.memoriesState)
    }

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
        .searchable(text: $searchQuery)
        .navigationTitle("Memories")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { isAddMemoryPresented = true }) {
                    Label("Add Memory", systemImage: "plus")
                }
            }
        }
        .sheet(
            isPresented: $isAddMemoryPresented,
            content: { AddMemoryPage() }
        )
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
