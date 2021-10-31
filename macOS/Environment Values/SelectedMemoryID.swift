//
//  Created by Kamil Powałowski on 31/10/2021.
//

import SwiftUI

private struct SelectedMemoryIDKey: EnvironmentKey {
    static let defaultValue: Binding<String?> = .constant(nil)
}

extension EnvironmentValues {
    var selectedMemoryID: Binding<String?> {
        get { self[SelectedMemoryIDKey.self] }
        set { self[SelectedMemoryIDKey.self] = newValue }
    }
}
