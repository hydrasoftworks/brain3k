//
//  Created by Kamil Powałowski on 02/10/2021.
//

import Fuse

extension Memory: Fuseable {
    var properties: [FuseProperty] {
        let properties = [
            FuseProperty(name: title ?? "", weight: 0.15),
            FuseProperty(name: description ?? "", weight: 0.15),
            FuseProperty(name: notes ?? "", weight: 0.2),
            FuseProperty(name: value, weight: 0.05),
        ]
        let tagWeight = 0.2 / Double(tags?.count ?? 1)
        let tagProperties = tags?.map { FuseProperty(name: $0, weight: tagWeight) }

        let customTagWeight = 0.25 / Double(customTags?.count ?? 1)
        let customTagProperties = customTags?.map { FuseProperty(name: $0, weight: customTagWeight) }

        return properties + (tagProperties ?? []) + (customTagProperties ?? [])
    }
}
