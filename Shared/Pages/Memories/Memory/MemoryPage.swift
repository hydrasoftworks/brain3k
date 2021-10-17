//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct MemoryPage: View {
    @Environment(\.dismiss) var dismiss

    let viewModel: ViewModel

    @ViewBuilder
    var body: some View {
        if viewModel.memoryExist {
            content
        } else {
            EmptyView(text: L10n.MemoryPage.Empty.notSelected(L10n.MemoriesPage.title))
        }
    }

    private var content: some View {
        UserInterfaceIdiomView(
            phone: {
                DeviceOrientationView(
                    portrait: { portrait },
                    landscape: { landscape }
                )
            },
            pad: { portrait }
        )
        .navigationTitle(L10n.MemoryPage.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    refreshButton
                    deleteButton
                }) {
                    Label(
                        L10n.MemoryPage.Button.menu,
                        systemImage: "ellipsis.circle"
                    )
                }
            }
        }
    }

    private var portrait: some View {
        VStack {
            ScrollView {
                if viewModel.hasImage {
                    MemoryImage(
                        viewModel.imageToDisplay,
                        onAppear: viewModel.getDownloadURL,
                        height: 250
                    )
                    .padding(.bottom)
                }
                if let text = viewModel.title { title(text) }
                if let text = viewModel.description { description(text) }
            }
            if let url = viewModel.valueURL {
                OpenMemoryButton(url: url)
            }
        }
    }

    private var landscape: some View {
        HStack {
            if viewModel.hasImage {
                MemoryImage(
                    viewModel.imageToDisplay,
                    onAppear: viewModel.getDownloadURL,
                    width: 300
                )
            }
            VStack {
                ScrollView {
                    if let text = viewModel.title { title(text) }
                    if let text = viewModel.description { description(text) }
                }
                if let url = viewModel.valueURL {
                    OpenMemoryButton(url: url)
                }
            }
        }
    }

    private var refreshButton: some View {
        Button(
            action: { viewModel.refresh() },
            label: {
                Label(
                    L10n.MemoryPage.Button.refresh,
                    systemImage: "arrow.triangle.2.circlepath"
                )
            }
        )
    }

    private var deleteButton: some View {
        Button(
            role: .destructive,
            action: {
                viewModel.delete()
                dismiss()
            }, label: {
                Label(
                    L10n.MemoryPage.Button.delete,
                    systemImage: "trash"
                )
            }
        )
    }

    private func title(_ text: String) -> some View {
        Text(text)
            .font(.title2)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom, 4)
    }

    private func description(_ text: String) -> some View {
        Text(text)
            .font(.body)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }

    struct ViewModel: Equatable {
        let memoryExist: Bool
        let image: URL?
        let imageToDisplay: URL?
        var hasImage: Bool { image != nil }
        let title: String?
        let description: String?
        let valueURL: URL?
        let delete: () -> Void
        let refresh: () -> Void
        let getDownloadURL: () -> Void

        static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
            lhs.memoryExist == rhs.memoryExist
                && lhs.image == rhs.image
                && lhs.imageToDisplay == rhs.imageToDisplay
                && lhs.title == rhs.title
                && lhs.description == rhs.description
                && lhs.valueURL == rhs.valueURL
        }
    }
}
