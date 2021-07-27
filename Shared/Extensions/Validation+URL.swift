//
//  Created by Kamil Powałowski on 27/07/2021.
//

import Foundation
import ValidatedPropertyKit

extension Validation where Value == String {
    static var isURL: Self {
        Validation.regularExpression("(?i)((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+")
    }
}
