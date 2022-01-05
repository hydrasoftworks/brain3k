//
//  Created by Kamil Powałowski on 19/09/2021.
//

import Combine
import Social
import UIKit
import UniformTypeIdentifiers

final class ShareViewController: SLComposeServiceViewController {
    let accountService = AccountService()
    let memoriesService = MemoriesService()
    let userService = UserService()

    var cancellable: AnyCancellable?

    private var notes: String? {
        contentText?.isEmpty == false ? contentText : nil
    }

    deinit {
        cancellable?.cancel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = nil
        placeholder = L10n.ShareExtension.notesPlaceholder
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.title = L10n.General.add
    }

    override func presentationAnimationDidFinish() {
        super.presentationAnimationDidFinish()
        setupPresentationAnimationDidFinish()
    }

    override func isContentValid() -> Bool { true }

    override func configurationItems() -> [Any] { [] }

    override func didSelectPost() {
        let attachments = (extensionContext?.inputItems.first as? NSExtensionItem)?.attachments ?? []

        let contentType = UTType.url.identifier
        guard let provider = attachments.first,
              provider.hasItemConformingToTypeIdentifier(contentType)
        else {
            return super.didSelectPost()
        }

        provider.loadItem(forTypeIdentifier: contentType, options: nil) { result, _ in
            guard let url = result as? URL else {
                return super.didSelectPost()
            }
            self.addURLMemory(url, notes: self.notes) { super.didSelectPost() }
        }
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

    func lockFormWithMessage(_ message: String) {
        placeholder = nil
        textView.resignFirstResponder()
        textView.isEditable = false
        textView.textColor = UIColor.secondaryLabel
        textView.text = message
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.isEnabled = false
    }
}
