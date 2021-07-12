//
//  Created by Kamil Powałowski on 12/07/2021.
//

@testable import Brain3k
import Nimble
import Quick

final class MessageStateSpec: QuickSpec {
    override func spec() {
        describe("\(MessageState.self) initial state") {
            var sut: MessageState!

            beforeEach {
                sut = MessageState()
            }

            it("shouldn't have message object") {
                expect(sut.message).to(beNil())
            }
        }
    }
}
