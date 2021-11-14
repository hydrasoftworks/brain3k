//
//  Created by Kamil Powałowski on 14/11/2021.
//

import SwiftUI

struct SharingServicePicker: NSViewRepresentable {
    @Binding var isPresented: Bool
    let items: [Any]

    func makeNSView(context _: Context) -> NSView {
        let view = NSView()
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        if isPresented {
            let picker = NSSharingServicePicker(items: items)
            picker.delegate = context.coordinator

            // Must be called async, otherwise blocks update
            DispatchQueue.main.async {
                picker.show(relativeTo: .zero, of: nsView, preferredEdge: .minY)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(owner: self)
    }

    class Coordinator: NSObject, NSSharingServicePickerDelegate {
        let owner: SharingServicePicker

        init(owner: SharingServicePicker) {
            self.owner = owner
        }

        func sharingServicePicker(
            _ sharingServicePicker: NSSharingServicePicker,
            didChoose _: NSSharingService?
        ) {
            sharingServicePicker.delegate = nil // << cleanup
            owner.isPresented = false // << dismiss
        }
    }
}
