//
//  Created by Kamil Powałowski on 24/07/2021.
//

@testable import Brain3k
import Foundation

extension Memory {
    static func test(
        type: MemoryType,
        value: String,
        thumbnail: String? = nil,
        title: String? = nil
    ) -> Memory {
        Memory(
            id: UUID().uuidString,
            createdAt: Date(),
            updatedAt: Date(),
            type: type,
            value: value,
            thumbnail: thumbnail,
            title: title,
            notes: nil,
            description: nil,
            tags: nil,
            additionalInfo: nil
        )
    }
}
