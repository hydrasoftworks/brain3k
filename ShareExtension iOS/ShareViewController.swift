//
//  Created by Kamil Powałowski on 19/09/2021.
//

import Social
import UIKit
import UniformTypeIdentifiers

final class ShareViewController: SLComposeServiceViewController {
    private let accountService = AccountService()
    private let memoriesService = MemoriesService()

    override func loadView() {
        super.loadView()
        let librariesService = LibrariesService()
        librariesService.initSwiftyBeaver()
        librariesService.initFirebase()

        textView.isEditable = false
        textView.textColor = UIColor.secondaryLabel
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.title = L10n.ShareExtension.primaryAction

        if accountService.getCurrentAccount() == nil {
            textView.text = L10n.ShareExtension.unsignedMessage(L10n.appName)
            navigationController?.navigationBar.topItem?.rightBarButtonItem?.isEnabled = false
        }
    }

    override func isContentValid() -> Bool { true }

    override func configurationItems() -> [Any] { [] }

    override func didSelectPost() {
        let attachments = (extensionContext?.inputItems.first as? NSExtensionItem)?.attachments ?? []
        guard !attachments.isEmpty else { return super.didSelectPost() }

        let contentType = UTType.url.identifier

        for provider in attachments {
            guard provider.hasItemConformingToTypeIdentifier(contentType) else {
                return super.didSelectPost()
            }
            provider.loadItem(forTypeIdentifier: contentType, options: nil) { result, _ in
                guard let url = result as? URL else {
                    return super.didSelectPost()
                }
                self.addURLMemory(url) { super.didSelectPost() }
            }
        }
    }

    private func addURLMemory(_ url: URL, completion: @escaping () -> Void) {
        guard let account = accountService.getCurrentAccount() else { return }
        _ = memoriesService.add(
            memory: Memory(type: .url, value: url.absoluteString),
            to: account.id
        )
        .sink(receiveCompletion: { _ in completion() }, receiveValue: {})
    }
}
