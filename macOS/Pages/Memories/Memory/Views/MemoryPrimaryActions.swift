//
//  MemoryPrimaryActions.swift
//  Brain3k macOS
//
//  Created by Kamil Powałowski on 14/11/2021.
//

import SwiftUI

struct MemoryPrimaryActions: View {
    let url: URL

    @State private var isSharingServicePickerPresented = false

    var body: some View {
        HStack(spacing: 16) {
            PrimaryButton(
                title: L10n.MemoryPage.Button.open,
                action: { NSWorkspace.shared.open(url) }
            )
            PrimaryIconButton(
                systemName: "square.and.arrow.up",
                label: L10n.MemoryPage.Button.share,
                action: { isSharingServicePickerPresented = true }
            )
            .background(
                SharingServicePicker(
                    isPresented: $isSharingServicePickerPresented,
                    items: [url]
                )
            )
        }
        .padding()
    }
}
