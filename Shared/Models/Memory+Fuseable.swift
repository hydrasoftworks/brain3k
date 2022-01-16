//
//  Created by Kamil Powałowski on 02/10/2021.
//

import Fuse

extension Memory: Fuseable {
    var properties: [FuseProperty] {
        let properties = [
            FuseProperty(name: title ?? "", weight: 0.15),
            FuseProperty(name: description ?? "", weight: 0.1),
            FuseProperty(name: summary ?? "", weight: 0.1),
            FuseProperty(name: notes ?? "", weight: 0.15),
            FuseProperty(name: value, weight: 0.05),
        ]
        let neuronWeight = 0.2 / Double(neurons?.count ?? 1)
        let neuronProperties = neurons?.map { FuseProperty(name: $0, weight: neuronWeight) }

        let tagWeight = 0.25 / Double(tags?.count ?? 1)
        let tagProperties = tags?.map { FuseProperty(name: $0, weight: tagWeight) }

        return properties + (neuronProperties ?? []) + (tagProperties ?? [])
    }
}
