//
//  Created by Kamil Powałowski on 20/08/2021.
//

import SwiftDux
import SwiftUI

struct URLMemoryCellConnector: ConnectableView {
    let memory: Memory

    func map(state: AppState) -> URLMemoryCell.ViewModel? {
        URLMemoryCell.ViewModel(
            title: memory.title,
            domain: memory.valueURL?.host ?? memory.value,
            image: memory.thumbnailURL,
            imageToDisplay: state.storageState.downloadURL(for: memory.thumbnailURL)
        )
    }

    func body(props viewModel: URLMemoryCell.ViewModel) -> some View {
        URLMemoryCell(viewModel: viewModel)
            .onAppear(dispatch: StorageAction.getDownloadURL(for: viewModel.image))
    }
}
