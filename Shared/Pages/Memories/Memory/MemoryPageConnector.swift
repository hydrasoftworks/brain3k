//
//  Created by Kamil Powałowski on 25/09/2021.
//

import SwiftDux
import SwiftUI

struct MemoryPageConnector: ConnectableView {
    let memoryId: String?

    func map(state: AppState) -> MemoryPage.ViewModel? {
        let memory = state.memoriesState.memory(forId: memoryId)
        return MemoryPage.ViewModel(
            image: memory?.thumbnailURL,
            imageToDisplay: state.storageState.downloadURL(for: memory?.thumbnailURL),
            title: memory?.title,
            description: memory?.description,
            valueURL: memory?.valueURL
        )
    }

    func body(props viewModel: MemoryPage.ViewModel) -> some View {
        MemoryPage(viewModel: viewModel)
    }
}
