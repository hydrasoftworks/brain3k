//
//  Created by Kamil Powałowski on 25/09/2021.
//

import SwiftDux
import SwiftUI

struct MemoryPageConnector: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    let memoryId: String?

    func map(state: AppState) -> MemoryPage.ViewModel? {
        let memory = state.memoriesState.memory(forId: memoryId)
        let image = memory?.thumbnailURL
        let title = (memory?.processed ?? false) ? memory?.title : L10n.General.processing

        return MemoryPage.ViewModel(
            memoryExist: memory != nil,
            image: image,
            imageToDisplay: state.storageState.downloadURL(for: memory?.thumbnailURL),
            title: title,
            description: memory?.description,
            valueURL: memory?.valueURL,
            delete: { dispatch.send(MemoriesAction.delete(memory: memory)) },
            refresh: { dispatch.send(MemoriesAction.refresh(memory: memory)) },
            getDownloadURL: { dispatch.send(StorageAction.getDownloadURL(for: image)) }
        )
    }

    func body(props viewModel: MemoryPage.ViewModel) -> some View {
        MemoryPage(viewModel: viewModel)
    }
}
