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
                let domain = "example.com"
                let sut = URLMemoryCell(
                    viewModel: URLMemoryCell.ViewModel(
                        title: nil,
                        domain: domain,
                        image: nil,
                        imageToDisplay: nil
                    )
                )

                let view = try sut.inspect().find(text: domain)
                expect(view).toNot(beNil())
            }

            it("Should display title") {
                let title = "Example title"
                let sut = URLMemoryCell(
                    viewModel: URLMemoryCell.ViewModel(
                        title: title,
                        domain: "example.com",
                        image: nil,
                        imageToDisplay: nil
                    )
                )

                let view = try sut.inspect().find(text: title)
                expect(view).toNot(beNil())
            }
        }
    }
}
