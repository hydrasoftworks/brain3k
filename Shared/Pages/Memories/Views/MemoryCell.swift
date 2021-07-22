//
//  Created by Kamil Powałowski on 21/07/2021.
//

import SwiftUI

struct MemoryCell: View {
    let memory: Memory

    var body: some View {
        switch memory.type {
        case .url: return URLMemoryCell(memory: memory)
        case .image: fatalError()
        }
    }
}

struct MemoryCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoryCell(
            memory: Memory(
                objectId: "1",
                type: .url,
                value: "https://swiftwombat.com",
                thumbnail: "https://swiftwombat.com/content/images/2020/12/cover.png",
                title: "Swift Wombat - Swift & SwiftUI knowledge base"
            )
        )
        .previewLayout(.fixed(width: 200, height: 200))
    }
}
