//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .buttonStyle(PrimaryButtonStyle())
    }
}

private struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        PrimaryButtonStyleView(configuration: configuration)
    }

    struct PrimaryButtonStyleView: View {
        @Environment(\.isEnabled) var isEnabled

        let configuration: PrimaryButtonStyle.Configuration

        var body: some View {
            configuration.label
                .font(.title2)
                .foregroundColor(isEnabled ? .white : .white.opacity(0.5))
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.brand.opacity(isEnabled ? 1 : 0.5))
                .cornerRadius(8)
                .opacity(configuration.isPressed ? 0.9 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
        }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Primary button", action: {})
    }
}
