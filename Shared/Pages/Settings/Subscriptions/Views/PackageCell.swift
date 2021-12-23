//
//  Created by Kamil Powałowski on 21/12/2021.
//

import RevenueCat
import SwiftUI

struct PackageCell: View {
    let package: Package
    let onSelection: (Package) -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(package.product.localizedTitle) (\(package.period))")
                    .font(.title3)
                    .bold()
                Text(package.product.localizedDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)

            Spacer(minLength: 8)

            Text(package.localizedPriceString)
                .font(.title3)
                .bold()
        }
        .modifier(PackageCellStyle())
        .contentShape(Rectangle())
        .onTapGesture { onSelection(package) }
    }
}

private struct PackageCellStyle: ViewModifier {
    func body(content: Content) -> some View {
        #if os(macOS)
            content
                .padding(.horizontal, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.brand, lineWidth: 2)
                )
                .padding(.horizontal, 8)
        #else
            content
        #endif
    }
}
