//
//  Created by Kamil Powałowski on 19/09/2021.
//

import Social
import UIKit
import UniformTypeIdentifiers

final class ShareViewController: SLComposeServiceViewController {
    private let accountService = AccountService()
    private let memoriesService = MemoriesService()

    private var notes: String? {
        contentText?.isEmpty == false ? contentText : nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        placeholder = L10n.ShareExtension.notesPlaceholder
        textView.text = nil
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.title = L10n.ShareExtension.primaryAction
    }

    override func presentationAnimationDidFinish() {
        super.presentationAnimationDidFinish()
        let librariesService = LibrariesService()
        librariesService.initSwiftyBeaver()
        librariesService.initFirebase()

        if accountService.getCurrentAccount() == nil {
            textView.resignFirstResponder()
            textView.isEditable = false
            textView.textColor = UIColor.secondaryLabel
            textView.text = L10n.ShareExtension.unsignedMessage(L10n.appName)
            navigationController?.navigationBar.topItem?.rightBarButtonItem?.isEnabled = false
        }
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
}
