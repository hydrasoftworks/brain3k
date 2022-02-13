//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct MemoryPage: View {
    @SwiftUI.State private var isReportConfirmationPresented = false
    @Environment(\.dismiss) var dismiss

    #if os(iOS)
        @Environment(\.verticalSizeClass) private var verticalSizeClass
        let pageTitle = L10n.MemoryPage.title
    #else
        let pageTitle = ""
    #endif

    let viewModel: ViewModel

    var body: some View {
        Group {
            if viewModel.memoryExist {
                content
            } else {
                EmptyListView(
                    image: Asset.robotNotSelected,
                    text: L10n.MemoryPage.Empty.notSelected
                )
            }
        }
        .navigationTitle(pageTitle)
    }

    private var content: some View {
        Group {
            #if os(iOS)
                if verticalSizeClass == .regular {
                    portrait
                } else {
                    landscape
                }
            #else
                portrait
            #endif
        }
        .toolbar {
            ToolbarItem {
                Menu(content: {
                    refreshButton
                    reportButton
                    deleteButton
                }) {
                    Label(
                        L10n.MemoryPage.Button.menu,
                        systemImage: "ellipsis.circle"
                    )
                }
            }
        }
        .confirmationDialog(
            L10n.MemoryPage.Confirmation.reportMemoryTitle,
            isPresented: $isReportConfirmationPresented,
            titleVisibility: .visible,
            actions: {
                Button(
                    L10n.MemoryPage.Confirmation.Button.reportMemory,
                    action: {
                        viewModel.report()
                        HapticService.notificationOccurred(.success)
                    }
                )
            }, message: {
                Text(L10n.MemoryPage.Confirmation.reportMemoryMessage)
            }
        )
    }

    private var portrait: some View {
        VStack {
            ScrollView {
                if viewModel.hasImage {
                    MemoryImage(
                        viewModel.imageToDisplay,
                        domain: viewModel.domain,
                        onAppear: viewModel.getDownloadURL,
                        height: 250
                    )
                }
                Spacer(minLength: 16)
                if let text = viewModel.title { title(text) }
                if let text = viewModel.description { description(text) }
                tags
                if let text = viewModel.summary { MemorySummaryView(text) }
                notes
            }
            if let url = viewModel.valueURL {
                MemoryPrimaryActions(url: url)
            }
        }
    }

    private var landscape: some View {
        HStack {
            if viewModel.hasImage {
                MemoryImage(
                    viewModel.imageToDisplay,
                    domain: viewModel.domain,
                    onAppear: viewModel.getDownloadURL,
                    width: 300
                )
            }
            VStack {
                ScrollView {
                    if let text = viewModel.title { title(text) }
                    if let text = viewModel.description { description(text) }
                    tags
                    if let text = viewModel.summary { MemorySummaryView(text) }
                    notes
                }
                if let url = viewModel.valueURL {
                    MemoryPrimaryActions(url: url)
                }
            }
        }
    }

    private var tags: some View {
        MemoryTagsView(
            tags: viewModel.tags,
            addTag: viewModel.addTag,
            deleteTag: viewModel.deleteTag
        )
    }

    private var notes: some View {
        MemoryNotesField(
            notes: viewModel.notes,
            updateNotes: viewModel.updateNotes
        )
    }

    private var refreshButton: some View {
        MemoryRefreshButton(
            action: {
                viewModel.refresh()
                HapticService.notificationOccurred(.success)
            }
        )
    }

    private var reportButton: some View {
        MemoryReportButton(
            action: { isReportConfirmationPresented = true }
        )
    }

    private var deleteButton: some View {
        MemoryDeleteButton(
            action: {
                viewModel.delete()
                #if os(iOS)
                    dismiss()
                #endif
                HapticService.notificationOccurred(.success)
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
            .textSelection(.enabled)
    }

    private func description(_ text: String) -> some View {
        Text(text)
            .font(.body)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom, 8)
            .textSelection(.enabled)
    }

    struct ViewModel: Equatable {
        let memoryExist: Bool
        let image: URL?
        let imageToDisplay: URL?
        var hasImage: Bool { image != nil }
        let title: String?
        let description: String?
        let summary: String?
        let valueURL: URL?
        let domain: String?
        let notes: String?
        let tags: [String]?

        let delete: () -> Void
        let refresh: () -> Void
        let report: () -> Void
        let getDownloadURL: () -> Void
        let updateNotes: (String) -> Void
        let addTag: (String) -> Void
        let deleteTag: (String) -> Void

        static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
            lhs.memoryExist == rhs.memoryExist
                && lhs.image == rhs.image
                && lhs.imageToDisplay == rhs.imageToDisplay
                && lhs.title == rhs.title
                && lhs.description == rhs.description
                && lhs.summary == rhs.summary
                && lhs.valueURL == rhs.valueURL
                && lhs.domain == rhs.domain
                && lhs.notes == rhs.notes
                && lhs.tags == rhs.tags
        }
    }
}
