//
//  Created by Kamil Powałowski on 24/07/2021.
//

@testable import Brain3k
import Foundation

extension Account {
    static func test(emailVerified: Bool = true) -> Account {
        Account(
            id: "1",
            email: "test@example.com",
            emailVerified: emailVerified
        )
    }
}
