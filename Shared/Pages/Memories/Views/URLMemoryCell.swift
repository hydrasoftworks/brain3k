//
//  Created by Kamil Powałowski on 22/07/2021.
//

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
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .expanded()
        } placeholder: {
            PlaceholderView()
        }
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

struct URLMemoryCell_Previews: PreviewProvider {
    static let memoryUrl1 = Memory.exampleURL()
    static let memoryUrl2 = Memory.exampleURL(thumbnail: false)

    static var previews: some View {
        Group {
            URLMemoryCell(
                viewModel: URLMemoryCell.ViewModel(
                    title: memoryUrl1.title,
                    domain: memoryUrl1.valueURL?.host ?? memoryUrl1.value,
                    image: memoryUrl1.thumbnailURL,
                    imageToDisplay: nil
                )
            )
            .previewLayout(.fixed(width: 200, height: 200))
            URLMemoryCell(
                viewModel: URLMemoryCell.ViewModel(
                    title: memoryUrl2.title,
                    domain: memoryUrl2.valueURL?.host ?? memoryUrl2.value,
                    image: memoryUrl2.thumbnailURL,
                    imageToDisplay: nil
                )
            )
            .previewLayout(.fixed(width: 200, height: 200))
        }
    }
}
