//
//  Created by Kamil Powałowski on 24/07/2021.
//

@testable import Brain3k
import Nimble
import Quick
import SwiftDux
import SwiftUI
import ViewInspector

final class MemoryCellSpec: QuickSpec {
    override func spec() {
        describe("\(MemoryCellSpec.self)") {
            context("unprocessed cell") {
                it("Should return ProcessingCell for memory type url") {
                    let sut = MemoryCell(
                        viewModel: self.viewModel(
                            Memory.test(
                                type: .url,
                                value: "https://example.com",
                                processed: false
                            )
                        )
                    )
                    let view = try sut.inspect().find(ProcessingCell.self)
                    expect(view).toNot(beNil())
                }
            }

            context("processed cell") {
                it("Should return URLMemoryCellConnector for memory type url") {
                    let sut = MemoryCell(
                        viewModel: self.viewModel(
                            Memory.test(
                                type: .url,
                                value: "https://example.com"
                            )
                        )
                    )
                    let view = try sut.inspect().find(URLMemoryCellConnector.self)
                    expect(view).toNot(beNil())
                }
            }
        }
    }

    private func viewModel(_ memory: Memory) -> MemoryCell.ViewModel {
        MemoryCell.ViewModel(
            memory: memory,
            delete: {},
            refresh: {},
            report: {}
        )
    }
}
