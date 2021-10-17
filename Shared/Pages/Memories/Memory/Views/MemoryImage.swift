//
//  Created by Kamil Powałowski on 16/10/2021.
//

import SwiftUI

struct MemoryImage: View {
    private let url: URL?
    private let height: CGFloat?
    private let width: CGFloat?
    private let onAppear: () -> Void

    init(
        _ url: URL?,
        onAppear: @escaping () -> Void,
        height: CGFloat? = nil,
        width: CGFloat? = nil
    ) {
        self.url = url
        self.width = width
        self.height = height
        self.onAppear = onAppear
    }

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            PlaceholderView()
                .onAppear(perform: onAppear)
        }
        .frame(
            minWidth: width, maxWidth: width,
            minHeight: height, maxHeight: height
        )
        .clipped()
    }
}
