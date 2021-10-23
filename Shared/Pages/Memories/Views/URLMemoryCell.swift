//
//  Created by Kamil Powałowski on 22/07/2021.
//

import NukeUI
import SwiftUI

struct URLMemoryCell: View {
    let viewModel: ViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.hasImage {
                image(viewModel.imageToDisplay)
            } else {
                domain(viewModel.domain)
            }
            if let text = viewModel.title {
                title(text)
            }
        }
    }

    private func image(_ url: URL?) -> some View {
        LazyImage(source: url) { state in
            if let image = state.image {
                image
                    .scaledToFill()
            } else if state.error != nil, url != nil {
                domain(viewModel.domain)
            } else {
                PlaceholderView()
            }
        }
        .expanded()
    }

    private func domain(_ text: String) -> some View {
        Text(text)
            .font(.title3)
            .foregroundColor(.white)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding()
            .expanded()
    }

    private func title(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .padding(8)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(.regularMaterial, in: Rectangle())
    }

    struct ViewModel: Equatable {
        let title: String?
        let domain: String
        let image: URL?
        let imageToDisplay: URL?
        var hasImage: Bool { image != nil }
    }
}
