//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct MemoriesPage: View {
    /*
      I don't know why, but ActionBinding from ViewModel doesn't store current search query when button on the keyboard is pressed.
     */
    @SwiftUI.State private var searchQuery: String = ""
    @SwiftUI.State private var isAddMemoryPresented: Bool = false

    let viewModel: ViewModel

    private var searchQueryBinding: Binding<String> {
        Binding<String>(
            get: { self.searchQuery },
            set: {
                self.searchQuery = $0
                viewModel.searchForQuery($0)
            }
        )
    }

    var body: some View {
        ScrollView {
            grid(viewModel)
                .padding(.horizontal)
                .padding(.bottom)
        }
        // Pull to Refresh doesn't work on ScrollView xD
        .refreshable { viewModel.getAllMemories() }
        .searchable(
            text: searchQueryBinding,
            placement: searchFieldPlacement
        )
        .navigationTitle(L10n.MemoriesPage.title)
        .toolbar {
            ToolbarItem {
                Button(
                    action: {
                        isAddMemoryPresented.toggle()
                        HapticService.impactOccurred(.light)
                    }
                ) {
                    Label(L10n.MemoriesPage.Button.add, systemImage: "plus")
                }
            }
        }
        .sheet(
            isPresented: $isAddMemoryPresented,
            content: { addMemorySheet }
        )
    }

    private var addMemorySheet: some View {
        #if os(iOS)
            NavigationView {
                AddMemoryPage()
            }
            .accentColor(Color.brand)
        #else
            AddMemoryPage()
                .frame(width: 300)
        #endif
    }

    @ViewBuilder
    private func grid(_ viewModel: ViewModel) -> some View {
        if viewModel.memories.isEmpty {
            EmptyListView(
                image: searchQuery.isEmpty
                    ? Asset.robotEmptyList
                    : Asset.robotNotFound,
                text: searchQuery.isEmpty
                    ? L10n.MemoriesPage.Empty.all
                    : L10n.MemoriesPage.Empty.search
            )
        } else {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 150), spacing: 16)],
                spacing: 16
            ) {
                ForEach(viewModel.memories) { memory in
                    MemoryCellConnector(memory: memory)
                }
            }
        }
    }

    private var searchFieldPlacement: SearchFieldPlacement {
        #if os(iOS)
            return .navigationBarDrawer(displayMode: .always)
        #else
            return .automatic
        #endif
    }

    struct ViewModel: Equatable {
        let memories: [Memory]
        let searchForQuery: (String) -> Void
        let getAllMemories: () -> Void

        static func == (lhs: MemoriesPage.ViewModel, rhs: MemoriesPage.ViewModel) -> Bool {
            lhs.memories == rhs.memories
        }
    }
}
