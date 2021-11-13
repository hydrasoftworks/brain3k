//
//  Created by Kamil Powałowski on 13/11/2021.
//

@testable import Brain3k
import Foundation

extension User {
    static func test(
        counter: Int,
        limit: Int
    ) -> User {
        User(
            id: UUID().uuidString,
            createdAt: Date(),
            updatedAt: Date(),
            counter: counter,
            limit: limit
        )
    }
}
