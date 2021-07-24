//
//  Created by Kamil Powałowski on 24/07/2021.
//

@testable import Brain3k
import Nimble
import Quick
import SwiftDux
import SwiftUI
import ViewInspector

extension PrimaryButton: Inspectable {}

final class PrimaryButtonSpec: QuickSpec {
    override func spec() {
        describe("\(PrimaryButton.self)") {
            it("should call provided action when tapped") {
                var actionCalled = false
                let sut = PrimaryButton(title: "Title", action: { actionCalled = true })
                try sut.inspect().button().tap()
                expect(actionCalled).to(beTrue())
            }
        }
    }
}
