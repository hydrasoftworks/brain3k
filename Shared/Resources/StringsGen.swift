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

  internal enum Alerts {
    internal enum Error {
      /// Houston, we have a problem.
      internal static let title = L10n.tr("Localizable", "alerts.error.title")
      /// Unknown error
      internal static let unknown = L10n.tr("Localizable", "alerts.error.unknown")
    }
    internal enum Info {
      /// Memory reported
      internal static let memoryReported = L10n.tr("Localizable", "alerts.info.memory_reported")
      /// Good news, everyone!
      internal static let title = L10n.tr("Localizable", "alerts.info.title")
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
    /// day
    internal static let day = L10n.tr("Localizable", "general.day")
    /// Loading...
    internal static let loading = L10n.tr("Localizable", "general.loading")
    /// month
    internal static let month = L10n.tr("Localizable", "general.month")
    /// OK
    internal static let ok = L10n.tr("Localizable", "general.ok")
    /// Processing...
    internal static let processing = L10n.tr("Localizable", "general.processing")
    /// Save
    internal static let save = L10n.tr("Localizable", "general.save")
    /// unknown
    internal static let unknown = L10n.tr("Localizable", "general.unknown")
    /// week
    internal static let week = L10n.tr("Localizable", "general.week")
    /// year
    internal static let year = L10n.tr("Localizable", "general.year")
    internal enum Legal {
      /// Privacy Policy
      internal static let privacyPolicy = L10n.tr("Localizable", "general.legal.privacy_policy")
      /// Terms and Conditions
      internal static let termsAndConditions = L10n.tr("Localizable", "general.legal.terms_and_conditions")
    }
  }

  internal enum HomePage {
    internal enum Menu {
      /// Menu
      internal static let title = L10n.tr("Localizable", "home_page.menu.title")
    }
  }

  internal enum JoinPage {
    internal enum Label {
      /// By joining, you are accepting [Terms and Conditions](%@).
      internal static func terms(_ p1: Any) -> String {
        return L10n.tr("Localizable", "join_page.label.terms", String(describing: p1))
      }
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
      /// No memories matching provided search query.
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
      /// Report memory
      internal static let report = L10n.tr("Localizable", "memory_page.button.report")
      /// Open memory
      internal static let share = L10n.tr("Localizable", "memory_page.button.share")
    }
    internal enum Confirmation {
      /// Processing memory can take up to 2 minutes. If it gives you a generic result, try to refresh your memory first. If that doesn't help, report it to us.
      internal static let reportMemoryMessage = L10n.tr("Localizable", "memory_page.confirmation.report_memory_message")
      /// Do you want to report this memory?
      internal static let reportMemoryTitle = L10n.tr("Localizable", "memory_page.confirmation.report_memory_title")
      internal enum Button {
        /// Yes, report this memory
        internal static let reportMemory = L10n.tr("Localizable", "memory_page.confirmation.button.report_memory")
      }
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
      /// Summary
      internal static let summary = L10n.tr("Localizable", "memory_page.label.summary")
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
      /// Contact support
      internal static let contactSupport = L10n.tr("Localizable", "settings_page.button.contact_support")
      /// Danger zone (press to reveal)
      internal static let dangerZone = L10n.tr("Localizable", "settings_page.button.danger_zone")
      /// Delete account
      internal static let deleteAccount = L10n.tr("Localizable", "settings_page.button.delete_account")
      /// Manage subscription
      internal static let manageSubscription = L10n.tr("Localizable", "settings_page.button.manageSubscription")
      /// Rate on App Store
      internal static let rate = L10n.tr("Localizable", "settings_page.button.rate")
      /// Restore subscription
      internal static let restoreSubscription = L10n.tr("Localizable", "settings_page.button.restoreSubscription")
      /// Sign out
      internal static let signOut = L10n.tr("Localizable", "settings_page.button.sign_out")
      /// More memories needed? Subscribe
      internal static let subscribe = L10n.tr("Localizable", "settings_page.button.subscribe")
    }
    internal enum Confirmation {
      /// This action cannot be undone.\nThe unused subscription period will be lost.
      internal static let deleteAccountMessage = L10n.tr("Localizable", "settings_page.confirmation.delete_account_message")
      /// Do you want to delete your account?
      internal static let deleteAccountTitle = L10n.tr("Localizable", "settings_page.confirmation.delete_account_title")
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

  internal enum SubscriptionsPage {
    /// %@ Pro
    internal static func title(_ p1: Any) -> String {
      return L10n.tr("Localizable", "subscriptions_page.title", String(describing: p1))
    }
    internal enum Labels {
      /// • Payment will be charged to your iTunes account at confirmation of purchase and will automatically renew (at the duration/price selected) unless auto-renew is turned off at least 24 hrs before the end of the current period.
      internal static let legal1 = L10n.tr("Localizable", "subscriptions_page.labels.legal1")
      /// • Account will be charged for renewal within 24-hours prior to the end of the current period.
      internal static let legal2 = L10n.tr("Localizable", "subscriptions_page.labels.legal2")
      /// • Current subscription may not be cancelled during the active subscription period; however, you can manage your subscription and/or turn off auto-renewal by visiting your iTunes Account Settings after purchase.
      internal static let legal3 = L10n.tr("Localizable", "subscriptions_page.labels.legal3")
      /// • Any unused portion of the free one month initial period will be forfeited when you purchases a subscription.
      internal static let legal4 = L10n.tr("Localizable", "subscriptions_page.labels.legal4")
      /// • [Privacy Policy](%@) and [Terms and Conditions](%@) applied.
      internal static func legal5(_ p1: Any, _ p2: Any) -> String {
        return L10n.tr("Localizable", "subscriptions_page.labels.legal5", String(describing: p1), String(describing: p2))
      }
    }
  }

  internal enum UnverifiedEmailPage {
    /// Go to your %s inbox and confirm message from %s. After that, press button below.
    internal static func description1(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "unverified_email_page.description1", p1, p2)
    }
    /// Didn't you receive a verification e-mail?
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
