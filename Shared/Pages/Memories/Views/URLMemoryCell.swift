//
//  Created by Kamil Powałowski on 22/07/2021.
//

import SwiftUI

struct URLMemoryCell: View {
    @State private var imageOpacity: Double = 0

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
        AppAsyncImage(
            url: url,
            image: { image in
                image
                    .resizable()
                    .scaledToFill()
            },
            placeholder: { PlaceholderView(color: .white) },
            error: { domain(viewModel.domain) }
        )
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
