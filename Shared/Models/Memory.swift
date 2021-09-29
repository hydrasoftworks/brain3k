//
//  Created by Kamil Powałowski on 27/06/2021.
//

import FirebaseFirestoreSwift
import Foundation
import Fuse

enum MemoryType: String, Codable {
    case url, image
}

struct Memory: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Date?
    @ServerTimestamp var updatedAt: Date?
    let type: MemoryType
    let value: String
    let thumbnail: String?
    let title: String?
    let notes: String?
    let description: String?
    let tags: [String]?
    let processed: Bool

    var thumbnailURL: URL? {
        guard let thumbnail = thumbnail else { return nil }
        return URL(string: thumbnail)
    }

    var valueURL: URL? { URL(string: value) }

    init(
        id: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        type: MemoryType,
        value: String,
        thumbnail: String? = nil,
        title: String? = nil,
        notes: String? = nil,
        description: String? = nil,
        tags: [String]? = nil,
        processed: Bool = false
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.type = type
        self.value = value
        self.thumbnail = thumbnail
        self.title = title
        self.notes = notes
        self.description = description
        self.tags = tags
        self.processed = processed
    }
}

extension Memory: Fuseable {
    var properties: [FuseProperty] {
        let tagWeight = 0.3 / Double(tags?.count ?? 1)

        let properties = [
            FuseProperty(name: title ?? "", weight: 0.2),
            FuseProperty(name: description ?? "", weight: 0.2),
            FuseProperty(name: notes ?? "", weight: 0.2),
            FuseProperty(name: value, weight: 0.1),
        ]
        let tagProperties = tags?.map { FuseProperty(name: $0, weight: tagWeight) }
        return properties + (tagProperties ?? [])
    }
}

extension Memory {
    static func exampleURL(thumbnail: Bool = true) -> Memory {
        Memory(
            id: "1",
            createdAt: Date(),
            updatedAt: Date(),
            type: .url,
            value: "https://swiftwombat.com",
            thumbnail: thumbnail ? "https://swiftwombat.com/content/images/2020/12/cover.png" : nil,
            title: "Swift Wombat - Swift & SwiftUI knowledge base",
            notes: nil,
            description: "Basic, intermediate, and advanced topics of iOS and macOS development. Knowledge base for mobile and desktop developers working on the Apple ecosystem.",
            tags: nil,
            processed: true
        )
    }
}
