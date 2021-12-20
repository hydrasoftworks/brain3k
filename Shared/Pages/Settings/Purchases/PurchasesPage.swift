//
//  Created by Kamil Powałowski on 20/12/2021.
//

import RevenueCat
import SwiftUI

struct PurchasesPage: View {
    let viewModel: ViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }

    struct ViewModel: Equatable {
        let offerings: Offerings?
    }
}
