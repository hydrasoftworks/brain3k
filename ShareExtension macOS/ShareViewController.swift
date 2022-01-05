//
//  Created by Kamil Powałowski on 01/11/2021.
//

import Cocoa
import Combine
import Social
import UniformTypeIdentifiers

class ShareViewController: SLComposeServiceViewController {
    let accountService = AccountService()
    let memoriesService = MemoriesService()
    let userService = UserService()

    var cancellable: AnyCancellable?

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
        sendButton()?.title = L10n.General.add
    }

    override func presentationAnimationDidFinish() {
        super.presentationAnimationDidFinish()
        setupPresentationAnimationDidFinish()
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

    private func sendButton() -> NSButton? {
        for subview in view.subviews {
            if let button = subview as? NSButton,
               button.action?.description.contains("_send:") ?? false
            {
                return button
            }
        }
        return nil
    }

    func lockFormWithMessage(_: String) {
        placeholder = nil
        textView.isEditable = false
        textView.isSelectable = false
        textView.textColor = NSColor.secondaryLabelColor
        textView.string = L10n.ShareExtension.unsignedMessage(L10n.appName)
        sendButton()?.isEnabled = false
    }
}
