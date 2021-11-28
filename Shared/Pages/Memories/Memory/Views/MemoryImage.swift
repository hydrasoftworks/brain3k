//
//  Created by Kamil Powałowski on 16/10/2021.
//

import SwiftUI

struct MemoryImage: View {
    @State private var imageOpacity: Double = 0
    @Environment(\.colorScheme) private var colorScheme

    private let url: URL?
    private let domain: String?
    private let height: CGFloat?
    private let width: CGFloat?
    private let onAppear: () -> Void

    init(
        _ url: URL?,
        domain: String?,
        onAppear: @escaping () -> Void,
        height: CGFloat? = nil,
        width: CGFloat? = nil
    ) {
        self.url = url
        self.domain = domain
        self.width = width
        self.height = height
        self.onAppear = onAppear
    }

    var body: some View {
        AppAsyncImage(
            url: url,
            transaction: .init(animation: .none),
            image: { image in
                image
                    .resizable()
                    .scaledToFill()
            },

            placeholder: {
                PlaceholderView(color: .primary)
                    .onAppear(perform: onAppear)
            },
            error: { domainView }
        )
        .frame(
            minWidth: width ?? 0, maxWidth: width ?? .infinity,
            minHeight: height ?? 0, maxHeight: height ?? .infinity
        )
        .clipped()
    }

    @ViewBuilder
    private var domainView: some View {
        if let text = domain {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: Color.gradient(colorScheme),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    Text(text)
                        .font(.title)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .padding()
                }

        } else {
            EmptyView()
        }
    }
}
