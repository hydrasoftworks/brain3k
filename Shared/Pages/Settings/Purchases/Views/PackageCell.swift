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
        .onTapGesture { onSelection(package) }
    }
}
