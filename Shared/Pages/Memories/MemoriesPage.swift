//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct MemoriesPage: View {
    @SwiftUI.State private var isAddMemoryPresented: Bool = false

    let viewModel: ViewModel

    var body: some View {
        ScrollView {
            grid(viewModel)
                .padding(.horizontal)
        }
        // Pull to Refresh doesn't work on ScrollView xD
        .refreshable { viewModel.getAllMemories() }
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

    @ViewBuilder
    private func grid(_ viewModel: ViewModel) -> some View {
        if viewModel.memories.isEmpty {
            EmptyView(
                text: viewModel.searchQuery.isEmpty
                    ? L10n.MemoriesPage.Empty.all
                    : L10n.MemoriesPage.Empty.search
            )
        } else {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 150), spacing: 16)],
                spacing: 16
            ) {
                ForEach(viewModel.memories) { memory in
                    MemoryCell(memory: memory)
                }
            }
        }
    }

    struct ViewModel: Equatable {
        let memories: [Memory]
        @ActionBinding var searchQuery: String
        let getAllMemories: () -> Void

        static func == (lhs: MemoriesPage.ViewModel, rhs: MemoriesPage.ViewModel) -> Bool {
            lhs.memories == rhs.memories
        }
    }
}
