//
//  Created by Kamil Powałowski on 22/07/2021.
//

import Nuke
import SwiftUI

struct URLMemoryCell: View {
    @StateObject private var fetchImage = FetchImage()

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

    @ViewBuilder
    private func image(_ url: URL?) -> some View {
        Group {
            if url != nil, let image = fetchImage.view {
                image
                    .resizable()
                    .scaledToFill()
            } else if !fetchImage.isLoading || url != nil {
                domain(viewModel.domain)
            } else {
                PlaceholderView(color: .white)
            }
        }
        .expanded()
        .onAppear { fetchImage.load(url) }
        .onChange(of: url) { fetchImage.load($0) }
        .onDisappear(perform: fetchImage.reset)
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
            .foregroundColor(Color.brand)
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
