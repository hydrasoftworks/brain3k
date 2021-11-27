//
//  Created by Kamil Powałowski on 16/10/2021.
//

import Nuke
import SwiftUI

struct MemoryImage: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var fetchImage = FetchImage()

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
        Group {
            if url != nil, let image = fetchImage.view {
                image
                    .resizable()
                    .scaledToFill()
            } else if !fetchImage.isLoading || url != nil {
                domainView
            } else {
                PlaceholderView(color: .primary)
                    .onAppear(perform: onAppear)
            }
        }
        .expanded()
        .frame(
            minWidth: width ?? 0, maxWidth: width ?? .infinity,
            minHeight: height ?? 0, maxHeight: height ?? .infinity
        )
        .clipped()
        .onAppear { fetchImage.load(url) }
        .onChange(of: url) { fetchImage.load($0) }
        .onDisappear(perform: fetchImage.reset)
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
