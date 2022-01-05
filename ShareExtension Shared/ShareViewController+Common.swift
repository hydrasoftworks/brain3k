//
//  Created by Kamil Powałowski on 05/01/2022.
//

import Foundation

extension ShareViewController {
    func setupPresentationAnimationDidFinish() {
        let librariesService = LibrariesService()
        librariesService.initSwiftyBeaver()
        librariesService.initFirebase()

        if let account = accountService.getCurrentAccount() {
            checkMemoryLimit(for: account.id)
        } else {
            lockFormWithMessage(L10n.ShareExtension.unsignedMessage(L10n.appName))
        }
    }

    func addURLMemory(_ url: URL, notes: String?, completion: @escaping () -> Void) {
        guard let account = accountService.getCurrentAccount() else { return }
        _ = memoriesService.add(
            memory: Memory(
                type: .url,
                value: url.absoluteString,
                notes: notes
            ),
            to: account.id
        )
        .sink(receiveCompletion: { _ in completion() }, receiveValue: {})
    }

    private func checkMemoryLimit(for accountId: String) {
        cancellable = userService.get(for: accountId)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] user in
                    if user?.canAddMemory == false { self?.lockFormWithMessage(L10n.ShareExtension.limitExceeded(L10n.appName)) }
                }
            )
    }
}
