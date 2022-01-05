//
//  Created by Kamil Powałowski on 05/01/2022.
//

import FirebaseFirestoreSwift
import Foundation

struct Report: Codable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Date?
    let type: MemoryType
    let value: String
    let reportedBy: String

    init(memory: Memory, accountId: String) {
        id = memory.id
        createdAt = nil
        type = memory.type
        value = memory.value
        reportedBy = accountId
    }
}
