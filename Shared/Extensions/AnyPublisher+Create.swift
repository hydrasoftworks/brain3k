//
//  Created by Kamil Powałowski on 12/08/2021.
//

import Combine
import Foundation

struct AnyObserver<Output, Failure> where Failure: Error {
    let onNext: (Output) -> Void
    let onError: (Failure) -> Void
    let onComplete: () -> Void
}

struct Disposable {
    let dispose: (() -> Void)?

    init(_ dispose: (() -> Void)? = nil) {
        self.dispose = dispose
    }
}

extension AnyPublisher {
    static func create(
        subscribe: @escaping (AnyObserver<Output, Failure>) -> Disposable
    ) -> Self {
        let subject = PassthroughSubject<Output, Failure>()
        var disposable: Disposable?
        return subject
            .handleEvents(
                receiveSubscription: { _ in
                    disposable = subscribe(
                        AnyObserver(
                            onNext: { output in subject.send(output) },
                            onError: { failure in subject.send(completion: .failure(failure)) },
                            onComplete: { subject.send(completion: .finished) }
                        )
                    )
                },
                receiveCancel: { disposable?.dispose?() }
            )
            .eraseToAnyPublisher()
    }
}
