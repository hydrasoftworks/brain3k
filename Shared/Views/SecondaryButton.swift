//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftUI

struct SecondaryButton: View {
    let title: String
    let role: ButtonRole?
    let action: () -> Void

    init(
        title: String,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.role = role
        self.action = action
    }

    var body: some View {
        Button(title, role: role, action: action)
            .buttonStyle(buttonStyle)
            .foregroundColor(color)
    }

    private var color: Color {
        if role == .destructive { return Color.red }
        return Color.brand
    }

    private var buttonStyle: some PrimitiveButtonStyle {
        #if os(iOS)
            .automatic
        #else
            .plain
        #endif
    }
}
