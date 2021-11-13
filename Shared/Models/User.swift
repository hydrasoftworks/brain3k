//
//  Created by Kamil Powałowski on 11/11/2021.
//

import FirebaseFirestoreSwift
import Foundation

struct User: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Date?
    @ServerTimestamp var updatedAt: Date?
    let counter: Int
    let limit: Int

    var canAddMemory: Bool { counter < limit }
}
