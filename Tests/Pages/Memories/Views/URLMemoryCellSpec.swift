//
//  Created by Kamil Powałowski on 24/07/2021.
//

@testable import Brain3k
import Nimble
import Quick
import SwiftUI
import ViewInspector

extension URLMemoryCell: Inspectable {}

final class URLMemoryCellSpec: QuickSpec {
    override func spec() {
        describe("\(URLMemoryCell.self)") {
            it("Should display domain name when thumbnail doesn't exist") {
                let sut = URLMemoryCell(
                    memory: Memory.test(type: .url, value: "https://example.com")
                )
                let view = try sut.inspect().find(text: "example.com")
                expect(view).toNot(beNil())
            }

            it("Should display title") {
                let title = "Example title"
                let sut = URLMemoryCell(
                    memory: Memory.test(
                        type: .url,
                        value: "https://example.com",
                        title: title
                    )
                )
                let view = try sut.inspect().find(text: title)
                expect(view).toNot(beNil())
            }
        }
    }
}
