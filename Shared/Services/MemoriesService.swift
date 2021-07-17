//
//  Created by Kamil Powałowski on 17/07/2021.
//

import Combine
import ParseSwift

class MemoriesService {
    func getAll() -> AnyPublisher<[Memory], AppError> {
        let query = Memory.query()
        return query.findAllPublisher()
            .mapToAppError()
    }
}
