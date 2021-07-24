//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Foundation

enum MemoryType: String, Codable {
    case url, image
}

struct Memory: Identifiable, Codable, Equatable {
    let id: String?
    let createdAt: Date?
    let updatedAt: Date?
    let type: MemoryType
    let value: String
    let thumbnail: String?
    let title: String?
    let notes: String?
    let description: String?
    let tags: [String]?
    let additionalInfo: [String: String]?

    var thumbnailURL: URL? {
        guard let thumbnail = thumbnail else { return nil }
        return URL(string: thumbnail)
    }

    var valueURL: URL? {
        URL(string: value)
    }

    func copyWithNil(thumbnail: Bool = false) -> Memory {
        Memory(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            type: type,
            value: value,
            thumbnail: thumbnail ? nil : self.thumbnail,
            title: title,
            notes: notes,
            description: description,
            tags: tags,
            additionalInfo: additionalInfo
        )
    }
}

extension Memory {
    static var exampleURL: Memory {
        Memory(
            id: "1",
            createdAt: Date(),
            updatedAt: Date(),
            type: .url,
            value: "https://swiftwombat.com",
            thumbnail: "https://swiftwombat.com/content/images/2020/12/cover.png",
            title: "Swift Wombat - Swift & SwiftUI knowledge base",
            notes: nil,
            description: nil,
            tags: nil,
            additionalInfo: nil
        )
    }
}
