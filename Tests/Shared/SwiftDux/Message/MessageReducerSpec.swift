//
//  Created by Kamil Powałowski on 12/07/2021.
//

@testable import Brain3k
import Nimble
import Quick

final class MessageReducerSpec: QuickSpec {
    override func spec() {
        describe("\(MessageReducer.self) should handle") {
            var sut: MessageReducer!

            beforeEach {
                sut = MessageReducer()
            }

            context("\(MessageAction.self) set") {
                it("should set message in state") {
                    let state = MessageState()
                    let message = Message.error("Test message")
                    let result = sut.reduce(
                        state: state,
                        action: .set(message)
                    )
                    expect(result.message).to(equal(message))
                }

                it("should replace current message") {
                    let message1 = Message.error("Test message 1")
                    let message2 = Message.error("Test message 2")
                    let state = MessageState(message: message1)
                    let result = sut.reduce(
                        state: state,
                        action: .set(message2)
                    )
                    expect(result.message).to(equal(message2))
                }
            }

            context("\(MessageAction.self) clear") {
                it("should do nothing when there is no message") {
                    let state = MessageState()
                    let result = sut.reduce(state: state, action: .clear)
                    expect(result.message).to(beNil())
                }

                it("should clear message in state") {
                    let message = Message.error("Test message")
                    let state = MessageState(message: message)
                    let result = sut.reduce(state: state, action: .clear)
                    expect(result.message).to(beNil())
                }
            }
        }
    }
}
