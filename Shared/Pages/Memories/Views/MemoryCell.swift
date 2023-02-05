//
//  Created by Kamil Powałowski on 21/07/2021.
//

import SwiftDux
import SwiftUI

struct MemoryCell: View {
    @Environment(\.colorScheme) private var colorScheme

    @SwiftUI.State private var isReportConfirmationPresented = false

    let viewModel: ViewModel

    var body: some View {
        Group {
            if let memory = viewModel.memory,
               memory.processed
            {
                switch memory.type {
                case .url: URLMemoryCellConnector(memory: memory)
                case .image: fatalError()
                }
            } else {
                ProcessingCell()
            }
        }
        .background(
            LinearGradient(
                colors: Color.gradient(colorScheme),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .animation(nil, value: UUID())
        )
        .contentShape(Rectangle())
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .contextMenu {
            refreshButton
            reportButton
            deleteButton
        }
        .reportConfirmationDialog(
            isPresented: $isReportConfirmationPresented,
            action: { viewModel.report() }
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
                HapticService.notificationOccurred(.success)
            }
        )
    }

    struct ViewModel: Equatable {
        let memory: Memory

        let delete: () -> Void
        let refresh: () -> Void
        let report: () -> Void

        static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
            lhs.memory == rhs.memory
        }
    }
}
