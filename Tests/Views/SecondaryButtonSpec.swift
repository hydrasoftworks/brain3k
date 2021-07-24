//
//  Created by Kamil Powałowski on 24/07/2021.
//

@testable import Brain3k
import Nimble
import Quick
import SwiftUI
import ViewInspector

extension SecondaryButton: Inspectable {}

final class SecondaryButtonSpec: QuickSpec {
    override func spec() {
        describe("\(SecondaryButton.self)") {
            it("Should call provided action when tapped") {
                var actionCalled = false
                let sut = SecondaryButton(title: "Title", action: { actionCalled = true })
                try sut.inspect().button().tap()
                expect(actionCalled).to(beTrue())
            }
        }
    }
}
