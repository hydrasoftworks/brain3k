//
//  Created by Kamil Powałowski on 24/07/2021.
//

@testable import Brain3k
import Foundation

extension Memory {
    static func test(
        type: MemoryType,
        value: String
    ) -> Memory {
        Memory(
            id: UUID().uuidString,
            createdAt: Date(),
            updatedAt: Date(),
            type: type,
            value: value,
            thumbnail: nil,
            title: nil,
            notes: nil,
            description: nil,
            tags: nil,
            additionalInfo: nil
        )
    }
}
