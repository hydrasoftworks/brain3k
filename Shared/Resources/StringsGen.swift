// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Brain3k
  internal static let appName = L10n.tr("Localizable", "app_name")

  internal enum AddMemoryPage {
    /// Add Memory
    internal static let title = L10n.tr("Localizable", "add_memory_page.title")
    internal enum LimitExceeded {
      /// The subscription is required to add more memories. Go to the settings to subscribe.
      internal static let body = L10n.tr("Localizable", "add_memory_page.limit_exceeded.body")
      /// Limit Exceeded
      internal static let title = L10n.tr("Localizable", "add_memory_page.limit_exceeded.title")
    }
    internal enum TextField {
      /// Paste URL here
      internal static let placeholder = L10n.tr("Localizable", "add_memory_page.text_field.placeholder")
    }
  }

  internal enum EmailTextField {
    /// e-mail
    internal static let placeholder = L10n.tr("Localizable", "email_text_field.placeholder")
  }

  internal enum General {
    /// Add
    internal static let add = L10n.tr("Localizable", "general.add")
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "general.cancel")
    /// Loading...
    internal static let loading = L10n.tr("Localizable", "general.loading")
    /// OK
    internal static let ok = L10n.tr("Localizable", "general.ok")
    /// Processing...
    internal static let processing = L10n.tr("Localizable", "general.processing")
    /// Save
    internal static let save = L10n.tr("Localizable", "general.save")
    internal enum Error {
      /// Houston, we have a problem
      internal static let title = L10n.tr("Localizable", "general.error.title")
    }
  }

  internal enum HomePage {
    internal enum Menu {
      /// Menu
      internal static let title = L10n.tr("Localizable", "home_page.menu.title")
    }
  }

  internal enum MemoriesPage {
    /// Memories
    internal static let title = L10n.tr("Localizable", "memories_page.title")
    internal enum Button {
      /// Add memory
      internal static let add = L10n.tr("Localizable", "memories_page.button.add")
    }
    internal enum Empty {
      /// Add your first memory using the + button above or by sharing the URL from any app.
      internal static let all = L10n.tr("Localizable", "memories_page.empty.all")
      /// Didn't find memories matching provided search query.
      internal static let search = L10n.tr("Localizable", "memories_page.empty.search")
    }
  }

  internal enum MemoryPage {
    /// Memory not found
    internal static let notFound = L10n.tr("Localizable", "memory_page.not_found")
    /// Memory
    internal static let title = L10n.tr("Localizable", "memory_page.title")
    internal enum Button {
      /// Add tag
      internal static let addTag = L10n.tr("Localizable", "memory_page.button.add_tag")
      /// Delete memory
      internal static let delete = L10n.tr("Localizable", "memory_page.button.delete")
      /// Delete tag
      internal static let deleteTag = L10n.tr("Localizable", "memory_page.button.delete_tag")
      /// Actions
      internal static let menu = L10n.tr("Localizable", "memory_page.button.menu")
      /// Open memory
      internal static let `open` = L10n.tr("Localizable", "memory_page.button.open")
      /// Refresh memory
      internal static let refresh = L10n.tr("Localizable", "memory_page.button.refresh")
      /// Open memory
      internal static let share = L10n.tr("Localizable", "memory_page.button.share")
    }
    internal enum Empty {
      /// No memory selected
      internal static let notSelected = L10n.tr("Localizable", "memory_page.empty.not_selected")
    }
    internal enum Label {
      /// Notes
      internal static let notes = L10n.tr("Localizable", "memory_page.label.notes")
      /// Press to add notes
      internal static let notesPlaceholder = L10n.tr("Localizable", "memory_page.label.notes_placeholder")
      /// Tags
      internal static let tags = L10n.tr("Localizable", "memory_page.label.tags")
    }
    internal enum TextField {
      /// Press return to save
      internal static let addTagPlaceholder = L10n.tr("Localizable", "memory_page.text_field.add_tag_placeholder")
    }
  }

  internal enum PasswordTextField {
    /// password (min. 8 characters)
    internal static let newPasswordPlaceholder = L10n.tr("Localizable", "password_text_field.new_password_placeholder")
    /// password
    internal static let passwordPlaceholder = L10n.tr("Localizable", "password_text_field.password_placeholder")
  }

  internal enum SettingsPage {
    /// Settings
    internal static let title = L10n.tr("Localizable", "settings_page.title")
    internal enum Button {
      /// Delete account
      internal static let deleteAccount = L10n.tr("Localizable", "settings_page.button.delete_account")
      /// Manage subscription
      internal static let manageSubscription = L10n.tr("Localizable", "settings_page.button.manageSubscription")
      /// Privacy policy
      internal static let privacyPolicy = L10n.tr("Localizable", "settings_page.button.privacy_policy")
      /// Rate on App Store
      internal static let rate = L10n.tr("Localizable", "settings_page.button.rate")
      /// Restore subscription
      internal static let restoreSubscription = L10n.tr("Localizable", "settings_page.button.restoreSubscription")
      /// Share feedback
      internal static let shareFeedback = L10n.tr("Localizable", "settings_page.button.share_feedback")
      /// Sign out
      internal static let signOut = L10n.tr("Localizable", "settings_page.button.sign_out")
      /// More memories needed? Subscribe
      internal static let subscribe = L10n.tr("Localizable", "settings_page.button.subscribe")
    }
    internal enum Confirmation {
      /// Do you want to delete your account?\nThis action cannot be undone.
      internal static let deleteAccount = L10n.tr("Localizable", "settings_page.confirmation.delete_account")
      internal enum Button {
        /// Yes, delete my account
        internal static let deleteAccount = L10n.tr("Localizable", "settings_page.confirmation.button.delete_account")
      }
    }
    internal enum Sections {
      /// Account
      internal static let account = L10n.tr("Localizable", "settings_page.sections.account")
      /// Links
      internal static let links = L10n.tr("Localizable", "settings_page.sections.links")
      /// Subscription
      internal static let subscription = L10n.tr("Localizable", "settings_page.sections.subscription")
    }
    internal enum Text {
      /// Current memories: %d
      internal static func memoriesCurrent(_ p1: Int) -> String {
        return L10n.tr("Localizable", "settings_page.text.memories_current", p1)
      }
      /// Available memories: %d
      internal static func memoriesLimit(_ p1: Int) -> String {
        return L10n.tr("Localizable", "settings_page.text.memories_limit", p1)
      }
    }
  }

  internal enum ShareExtension {
    /// The subscription is required to add more memories. Go to the %s app settings to subscribe.
    internal static func limitExceeded(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "share_extension.limit_exceeded", p1)
    }
    /// Add to %s
    internal static func name(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "share_extension.name", p1)
    }
    /// Notes (optional)
    internal static let notesPlaceholder = L10n.tr("Localizable", "share_extension.notes_placeholder")
    /// Go to the %s app and sign in to perform this operation.
    internal static func unsignedMessage(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "share_extension.unsigned_message", p1)
    }
  }

  internal enum SignInPage {
    /// Log back to your digital brain.
    internal static let description1 = L10n.tr("Localizable", "sign_in_page.description1")
    /// or sign in using email and password
    internal static let description2 = L10n.tr("Localizable", "sign_in_page.description2")
    /// Welcome back
    internal static let title = L10n.tr("Localizable", "sign_in_page.title")
    internal enum Button {
      /// Sign in with e-mail
      internal static let signIn = L10n.tr("Localizable", "sign_in_page.button.sign_in")
      /// You are new? Create an account.
      internal static let signUp = L10n.tr("Localizable", "sign_in_page.button.sign_up")
    }
  }

  internal enum SignInWithAppleButton {
    /// Authorization failed: %s
    internal static func error(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "sign_in_with_apple_button.error", p1)
    }
  }

  internal enum SignUpPage {
    /// Start using your new digital brain.
    internal static let description1 = L10n.tr("Localizable", "sign_up_page.description1")
    /// or sign up using email and password
    internal static let description2 = L10n.tr("Localizable", "sign_up_page.description2")
    /// Create an account
    internal static let title = L10n.tr("Localizable", "sign_up_page.title")
    internal enum Button {
      /// Already have an account? Sign in now.
      internal static let signIn = L10n.tr("Localizable", "sign_up_page.button.sign_in")
      /// Sign up with e-mail
      internal static let signUp = L10n.tr("Localizable", "sign_up_page.button.sign_up")
    }
  }

  internal enum UnverifiedEmailPage {
    /// Go to your %s inbox and confirm message from %s. After that, press button below.
    internal static func description1(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "unverified_email_page.description1", p1, p2)
    }
    /// Didn't received verification email?
    internal static let description2 = L10n.tr("Localizable", "unverified_email_page.description2")
    /// or
    internal static let description3 = L10n.tr("Localizable", "unverified_email_page.description3")
    /// Email address verification needed
    internal static let title = L10n.tr("Localizable", "unverified_email_page.title")
    internal enum Button {
      /// Send verification email
      internal static let send = L10n.tr("Localizable", "unverified_email_page.button.send")
      /// Sign out
      internal static let signOut = L10n.tr("Localizable", "unverified_email_page.button.sign_out")
      /// Email verified
      internal static let verified = L10n.tr("Localizable", "unverified_email_page.button.verified")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
