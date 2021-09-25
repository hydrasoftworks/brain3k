//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct MemoryPage: View {
    let viewModel: ViewModel

    var body: some View {
        VStack {
            ScrollView {
                if viewModel.hasImage {
                    if let url = viewModel.imageToDisplay {
                        image(url)
                    } else {
                        PlaceholderView()
                    }
                }
                if let text = viewModel.title { title(text) }
                if let text = viewModel.description { description(text) }
            }
            if let url = viewModel.valueURL {
                OpenMemoryButton(url: url)
            }
        }
        .navigationTitle(L10n.MemoryPage.title)
    }

    private func image(_ url: URL) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            PlaceholderView()
        }
        .frame(minHeight: 250, maxHeight: 250)
        .clipped()
        .padding(.bottom)
    }

    private func title(_ text: String) -> some View {
        Text(text)
            .font(.title2)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom, 4)
    }

    private func description(_ text: String) -> some View {
        Text(text)
            .font(.body)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }

    struct ViewModel: Equatable {
        let image: URL?
        let imageToDisplay: URL?
        var hasImage: Bool { image != nil }
        let title: String?
        let description: String?
        let valueURL: URL?
    }
}

struct MemoryPage_Previews: PreviewProvider {
    static let memoryUrl = Memory.exampleURL()

    static var previews: some View {
        MemoryPage(
            viewModel: MemoryPage.ViewModel(
                image: memoryUrl.thumbnailURL,
                imageToDisplay: nil,
                title: memoryUrl.title,
                description: memoryUrl.description,
                valueURL: memoryUrl.valueURL
            )
        )
    }
}
