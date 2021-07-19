//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Foundation
import ParseSwift

enum MemoryType: String, Codable {
    case url, image
}

struct Memory: ParseObject, Identifiable {
    var id: String? { objectId }

    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?

    var type: MemoryType
    var value: String
    var thumbnail: String?
    var title: String?
    var notes: String?
    var description: String?
    var tags: [String]?
    var additionalInfo: [String: String]?

    var thumbnailURL: URL? {
        guard let thumbnail = thumbnail else { return nil }
        return URL(string: thumbnail)
    }
}
