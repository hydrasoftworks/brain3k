//
//  Created by Kamil Powałowski on 02/10/2021.
//

import Fuse

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
