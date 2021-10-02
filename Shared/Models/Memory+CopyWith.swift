//
//  Created by Kamil Powałowski on 02/10/2021.
//

import Foundation

extension Memory {
    func copyWith(
        id: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        type: MemoryType? = nil,
        value: String? = nil,
        thumbnail: String? = nil,
        title: String? = nil,
        notes: String? = nil,
        description: String? = nil,
        tags: [String]? = nil,
        processed: Bool? = nil
    ) -> Memory {
        Memory(
            id: id ?? self.id,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            type: type ?? self.type,
            value: value ?? self.value,
            thumbnail: thumbnail ?? self.thumbnail,
            title: title ?? self.title,
            notes: notes ?? self.notes,
            description: description ?? self.description,
            tags: tags ?? self.tags,
            processed: processed ?? self.processed
        )
    }

    func copyWithNil(
        id: Bool = false,
        createdAt: Bool = false,
        updatedAt: Bool = false,
        thumbnail: Bool = false,
        title: Bool = false,
        notes: Bool = false,
        description: Bool = false,
        tags: Bool = false
    ) -> Memory {
        Memory(
            id: id ? nil : self.id,
            createdAt: createdAt ? nil : self.createdAt,
            updatedAt: updatedAt ? nil : self.updatedAt,
            type: type,
            value: value,
            thumbnail: thumbnail ? nil : self.thumbnail,
            title: title ? nil : self.title,
            notes: notes ? nil : self.notes,
            description: description ? nil : self.description,
            tags: tags ? nil : self.tags,
            processed: processed
        )
    }
}
