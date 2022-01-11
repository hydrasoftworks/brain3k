//
//  Created by Kamil Powałowski on 11/01/2022.
//

import SwiftUI

struct MarkdownText: View {
    let text: String

    var body: some View {
        Text((try? AttributedString(markdown: text)) ?? AttributedString(text))
    }
}
