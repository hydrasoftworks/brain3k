//
//  Created by Kamil Powałowski on 14/11/2021.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(
        context _: UIViewControllerRepresentableContext<ActivityView>
    ) -> UIActivityViewController {
        UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
    }

    func updateUIViewController(
        _: UIActivityViewController,
        context _: UIViewControllerRepresentableContext<ActivityView>
    ) {}
}
