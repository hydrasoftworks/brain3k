//
//  Created by Kamil Powałowski on 01/11/2021.
//

import Cocoa
import Combine
import Social
import UniformTypeIdentifiers

class ShareViewController: SLComposeServiceViewController {
    private let accountService = AccountService()
    private let memoriesService = MemoriesService()
    private let userService = UserService()

    private var cancellable: AnyCancellable?

    private var notes: String? {
        contentText?.isEmpty == false ? contentText : nil
    }

    private static var cancelError: NSError {
        NSError(domain: NSCocoaErrorDomain, code: NSUserCancelledError, userInfo: nil)
    }

    deinit {
        cancellable?.cancel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = L10n.ShareExtension.name(L10n.appName)
        placeholder = L10n.ShareExtension.notesPlaceholder
        sendButton()?.title = L10n.ShareExtension.primaryAction
    }

    override func presentationAnimationDidFinish() {
        super.presentationAnimationDidFinish()
        let librariesService = LibrariesService()
        librariesService.initSwiftyBeaver()
        librariesService.initFirebase()

        if let account = accountService.getCurrentAccount() {
            checkMemoryLimit(for: account.id)
        } else {
            lockFormWithMessage(L10n.ShareExtension.unsignedMessage(L10n.appName))
        }
    }

    override func isContentValid() -> Bool { true }

    override func didSelectPost() {
        let inputItem = extensionContext?.inputItems.first as? NSExtensionItem
        let attachments = inputItem?.attachments ?? []

        let contentType = UTType.url.identifier
        guard let provider = attachments.first,
              provider.hasItemConformingToTypeIdentifier(contentType)
        else {
            extensionContext?.cancelRequest(withError: ShareViewController.cancelError)
            return
        }

        provider.loadItem(forTypeIdentifier: contentType, options: nil) { [weak self] result, _ in
            guard let data = result as? Data,
                  let url = URL(dataRepresentation: data, relativeTo: nil)
            else {
                self?.extensionContext?.cancelRequest(withError: ShareViewController.cancelError)
                return
            }
            self?.addURLMemory(url, notes: self?.notes) { [weak self] in
                let outputItems = [inputItem?.copy()].compactMap { $0 }
                self?.extensionContext?.completeRequest(
                    returningItems: outputItems,
                    completionHandler: nil
                )
            }
        }
    }

    private func addURLMemory(_ url: URL, notes: String?, completion: @escaping () -> Void) {
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

    private func sendButton() -> NSButton? {
        for subview in view.subviews {
            if let button = subview as? NSButton {
                if button.action?.description.contains("_send:") ?? false {
                    return button
                }
            }
        }
        return nil
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

    private func lockFormWithMessage(_: String) {
        placeholder = nil
        textView.isEditable = false
        textView.isSelectable = false
        textView.textColor = NSColor.secondaryLabelColor
        textView.string = L10n.ShareExtension.unsignedMessage(L10n.appName)
        sendButton()?.isEnabled = false
    }
}
