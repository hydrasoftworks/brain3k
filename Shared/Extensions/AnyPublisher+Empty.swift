//
//  Created by Kamil Powałowski on 10/07/2021.
//

import Combine

extension AnyPublisher {
    static var empty: AnyPublisher { Empty().eraseToAnyPublisher() }
}
