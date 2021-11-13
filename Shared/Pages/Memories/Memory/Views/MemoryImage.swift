//
//  Created by Kamil Powałowski on 16/10/2021.
//

import NukeUI
import SwiftUI

struct MemoryImage: View {
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
        LazyImage(source: url) { state in
            if let image = state.image {
                image
                    .scaledToFill()
            } else if state.error != nil, url != nil {
                domainView
            } else {
                PlaceholderView(color: .primary)
                    .onAppear(perform: onAppear)
            }
        }
        .expanded()
        .frame(
            minWidth: width, maxWidth: width,
            minHeight: height, maxHeight: height
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
