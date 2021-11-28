//
//  Created by Kamil Powałowski on 28/11/2021.
//

import CachedAsyncImage
import SwiftUI

// NukeUI LazyImage doesn't scale correctly on macOS
// This is a temporary solution until fix
struct AppAsyncImage<ContentImage, ContentPlaceholder, ContentError>: View where ContentImage: View, ContentPlaceholder: View, ContentError: View {
    @State private var imageOpacity: Double = 0

    private let url: URL?
    private let transaction: Transaction
    private let image: (Image) -> ContentImage
    private let placeholder: () -> ContentPlaceholder
    private let error: () -> ContentError

    init(
        url: URL?,
        transaction: Transaction = .init(animation: .default),
        image: @escaping (Image) -> ContentImage,
        placeholder: @escaping () -> ContentPlaceholder,
        error: @escaping () -> ContentError
    ) {
        self.url = url
        self.transaction = transaction
        self.image = image
        self.placeholder = placeholder
        self.error = error
    }

    var body: some View {
        CachedAsyncImage(
            url: url,
            urlCache: .images,
            transaction: transaction
        ) { phase in
            switch phase {
            case .empty:
                placeholder()
            case let .success(image):
                self.image(image)
                    .opacity(imageOpacity)
                    .transition(.opacity)
                    .onAppear { imageOpacity = 1 }
            case .failure:
                error()
            @unknown default:
                EmptyView()
            }
        }
    }
}
