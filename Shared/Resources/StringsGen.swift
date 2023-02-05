// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Brain3k
  internal static let appName = L10n.tr("Localizable", "app_name", fallback: "Brain3k")
  internal enum AddMemoryPage {
    /// Add Memory
    internal static let title = L10n.tr("Localizable", "add_memory_page.title", fallback: "Add Memory")
    internal enum LimitExceeded {
      /// The subscription is required to add more memories. Go to the settings to subscribe.
      internal static let body = L10n.tr("Localizable", "add_memory_page.limit_exceeded.body", fallback: "The subscription is required to add more memories. Go to the settings to subscribe.")
      /// Limit Exceeded
      internal static let title = L10n.tr("Localizable", "add_memory_page.limit_exceeded.title", fallback: "Limit Exceeded")
    }
    internal enum TextField {
      /// Paste URL here
      internal static let placeholder = L10n.tr("Localizable", "add_memory_page.text_field.placeholder", fallback: "Paste URL here")
    }
  }
  internal enum Alerts {
    internal enum Error {
      /// Houston, we have a problem.
      internal static let title = L10n.tr("Localizable", "alerts.error.title", fallback: "Houston, we have a problem.")
      /// Unknown error
      internal static let unknown = L10n.tr("Localizable", "alerts.error.unknown", fallback: "Unknown error")
    }
    internal enum Info {
      /// Memory reported
      internal static let memoryReported = L10n.tr("Localizable", "alerts.info.memory_reported", fallback: "Memory reported")
      /// Good news, everyone!
      internal static let title = L10n.tr("Localizable", "alerts.info.title", fallback: "Good news, everyone!")
    }
  }
  internal enum EmailTextField {
    /// e-mail
    internal static let placeholder = L10n.tr("Localizable", "email_text_field.placeholder", fallback: "e-mail")
  }
  internal enum General {
    /// Add
    internal static let add = L10n.tr("Localizable", "general.add", fallback: "Add")
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "general.cancel", fallback: "Cancel")
    /// day
    internal static let day = L10n.tr("Localizable", "general.day", fallback: "day")
    /// Loading...
    internal static let loading = L10n.tr("Localizable", "general.loading", fallback: "Loading...")
    /// month
    internal static let month = L10n.tr("Localizable", "general.month", fallback: "month")
    /// OK
    internal static let ok = L10n.tr("Localizable", "general.ok", fallback: "OK")
    /// Processing...
    internal static let processing = L10n.tr("Localizable", "general.processing", fallback: "Processing...")
    /// Save
    internal static let save = L10n.tr("Localizable", "general.save", fallback: "Save")
    /// unknown
    internal static let unknown = L10n.tr("Localizable", "general.unknown", fallback: "unknown")
    /// week
    internal static let week = L10n.tr("Localizable", "general.week", fallback: "week")
    /// year
    internal static let year = L10n.tr("Localizable", "general.year", fallback: "year")
    internal enum Legal {
      /// Privacy Policy
      internal static let privacyPolicy = L10n.tr("Localizable", "general.legal.privacy_policy", fallback: "Privacy Policy")
      /// Terms and Conditions
      internal static let termsAndConditions = L10n.tr("Localizable", "general.legal.terms_and_conditions", fallback: "Terms and Conditions")
    }
  }
  internal enum HomePage {
    internal enum Menu {
      /// Menu
      internal static let title = L10n.tr("Localizable", "home_page.menu.title", fallback: "Menu")
    }
  }
  internal enum JoinPage {
    internal enum Label {
      /// By joining, you are accepting [Terms and Conditions](%@).
      internal static func terms(_ p1: Any) -> String {
        return L10n.tr("Localizable", "join_page.label.terms", String(describing: p1), fallback: "By joining, you are accepting [Terms and Conditions](%@).")
      }
    }
  }
  internal enum MemoriesPage {
    /// Memories
    internal static let title = L10n.tr("Localizable", "memories_page.title", fallback: "Memories")
    internal enum Button {
      /// Add memory
      internal static let add = L10n.tr("Localizable", "memories_page.button.add", fallback: "Add memory")
    }
    internal enum Empty {
      /// Add your first memory using the + button above or by sharing the URL from any app.
      internal static let all = L10n.tr("Localizable", "memories_page.empty.all", fallback: "Add your first memory using the + button above or by sharing the URL from any app.")
      /// No memories matching provided search query.
      internal static let search = L10n.tr("Localizable", "memories_page.empty.search", fallback: "No memories matching provided search query.")
    }
  }
  internal enum MemoryPage {
    /// Memory not found
    internal static let notFound = L10n.tr("Localizable", "memory_page.not_found", fallback: "Memory not found")
    /// Memory
    internal static let title = L10n.tr("Localizable", "memory_page.title", fallback: "Memory")
    internal enum Button {
      /// Add tag
      internal static let addTag = L10n.tr("Localizable", "memory_page.button.add_tag", fallback: "Add tag")
      /// Delete memory
      internal static let delete = L10n.tr("Localizable", "memory_page.button.delete", fallback: "Delete memory")
      /// Delete tag
      internal static let deleteTag = L10n.tr("Localizable", "memory_page.button.delete_tag", fallback: "Delete tag")
      /// Actions
      internal static let menu = L10n.tr("Localizable", "memory_page.button.menu", fallback: "Actions")
      /// Open memory
      internal static let `open` = L10n.tr("Localizable", "memory_page.button.open", fallback: "Open memory")
      /// Refresh memory
      internal static let refresh = L10n.tr("Localizable", "memory_page.button.refresh", fallback: "Refresh memory")
      /// Report memory
      internal static let report = L10n.tr("Localizable", "memory_page.button.report", fallback: "Report memory")
      /// Open memory
      internal static let share = L10n.tr("Localizable", "memory_page.button.share", fallback: "Open memory")
    }
    internal enum Empty {
      /// No memory selected
      internal static let notSelected = L10n.tr("Localizable", "memory_page.empty.not_selected", fallback: "No memory selected")
    }
    internal enum Label {
      /// Notes
      internal static let notes = L10n.tr("Localizable", "memory_page.label.notes", fallback: "Notes")
      /// Press to add notes
      internal static let notesPlaceholder = L10n.tr("Localizable", "memory_page.label.notes_placeholder", fallback: "Press to add notes")
      /// Summary
      internal static let summary = L10n.tr("Localizable", "memory_page.label.summary", fallback: "Summary")
      /// Tags
      internal static let tags = L10n.tr("Localizable", "memory_page.label.tags", fallback: "Tags")
    }
    internal enum TextField {
      /// Press return to save
      internal static let addTagPlaceholder = L10n.tr("Localizable", "memory_page.text_field.add_tag_placeholder", fallback: "Press return to save")
    }
  }
  internal enum PasswordTextField {
    /// password (min. 8 characters)
    internal static let newPasswordPlaceholder = L10n.tr("Localizable", "password_text_field.new_password_placeholder", fallback: "password (min. 8 characters)")
    /// password
    internal static let passwordPlaceholder = L10n.tr("Localizable", "password_text_field.password_placeholder", fallback: "password")
  }
  internal enum ReportMemoryConfirmation {
    /// Processing memory can take up to 2 minutes. If it gives you a generic result, try to refresh your memory first. If that doesn't help, report it to us.
    internal static let reportMemoryMessage = L10n.tr("Localizable", "report_memory_confirmation.report_memory_message", fallback: "Processing memory can take up to 2 minutes. If it gives you a generic result, try to refresh your memory first. If that doesn't help, report it to us.")
    /// Do you want to report this memory?
    internal static let reportMemoryTitle = L10n.tr("Localizable", "report_memory_confirmation.report_memory_title", fallback: "Do you want to report this memory?")
    internal enum Button {
      /// Yes, report this memory
      internal static let reportMemory = L10n.tr("Localizable", "report_memory_confirmation.button.report_memory", fallback: "Yes, report this memory")
    }
  }
  internal enum SettingsPage {
    /// Settings
    internal static let title = L10n.tr("Localizable", "settings_page.title", fallback: "Settings")
    internal enum Button {
      /// Contact support
      internal static let contactSupport = L10n.tr("Localizable", "settings_page.button.contact_support", fallback: "Contact support")
      /// Danger zone (press to reveal)
      internal static let dangerZone = L10n.tr("Localizable", "settings_page.button.danger_zone", fallback: "Danger zone (press to reveal)")
      /// Delete account
      internal static let deleteAccount = L10n.tr("Localizable", "settings_page.button.delete_account", fallback: "Delete account")
      /// Manage subscription
      internal static let manageSubscription = L10n.tr("Localizable", "settings_page.button.manageSubscription", fallback: "Manage subscription")
      /// Rate on App Store
      internal static let rate = L10n.tr("Localizable", "settings_page.button.rate", fallback: "Rate on App Store")
      /// Restore subscription
      internal static let restoreSubscription = L10n.tr("Localizable", "settings_page.button.restoreSubscription", fallback: "Restore subscription")
      /// Sign out
      internal static let signOut = L10n.tr("Localizable", "settings_page.button.sign_out", fallback: "Sign out")
      /// More memories needed? Subscribe
      internal static let subscribe = L10n.tr("Localizable", "settings_page.button.subscribe", fallback: "More memories needed? Subscribe")
    }
    internal enum Confirmation {
      /// This action cannot be undone.
      /// The unused subscription period will be lost.
      internal static let deleteAccountMessage = L10n.tr("Localizable", "settings_page.confirmation.delete_account_message", fallback: "This action cannot be undone.\nThe unused subscription period will be lost.")
      /// Do you want to delete your account?
      internal static let deleteAccountTitle = L10n.tr("Localizable", "settings_page.confirmation.delete_account_title", fallback: "Do you want to delete your account?")
      internal enum Button {
        /// Yes, delete my account
        internal static let deleteAccount = L10n.tr("Localizable", "settings_page.confirmation.button.delete_account", fallback: "Yes, delete my account")
      }
    }
    internal enum Sections {
      /// Account
      internal static let account = L10n.tr("Localizable", "settings_page.sections.account", fallback: "Account")
      /// Links
      internal static let links = L10n.tr("Localizable", "settings_page.sections.links", fallback: "Links")
      /// Subscription
      internal static let subscription = L10n.tr("Localizable", "settings_page.sections.subscription", fallback: "Subscription")
    }
    internal enum Text {
      /// Current memories: %d
      internal static func memoriesCurrent(_ p1: Int) -> String {
        return L10n.tr("Localizable", "settings_page.text.memories_current", p1, fallback: "Current memories: %d")
      }
      /// Available memories: %d
      internal static func memoriesLimit(_ p1: Int) -> String {
        return L10n.tr("Localizable", "settings_page.text.memories_limit", p1, fallback: "Available memories: %d")
      }
    }
  }
  internal enum ShareExtension {
    /// The subscription is required to add more memories. Go to the %s app settings to subscribe.
    internal static func limitExceeded(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "share_extension.limit_exceeded", p1, fallback: "The subscription is required to add more memories. Go to the %s app settings to subscribe.")
    }
    /// Add to %s
    internal static func name(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "share_extension.name", p1, fallback: "Add to %s")
    }
    /// Notes (optional)
    internal static let notesPlaceholder = L10n.tr("Localizable", "share_extension.notes_placeholder", fallback: "Notes (optional)")
    /// Go to the %s app and sign in to perform this operation.
    internal static func unsignedMessage(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "share_extension.unsigned_message", p1, fallback: "Go to the %s app and sign in to perform this operation.")
    }
  }
  internal enum SignInPage {
    /// Log back to your digital brain.
    internal static let description1 = L10n.tr("Localizable", "sign_in_page.description1", fallback: "Log back to your digital brain.")
    /// or sign in using email and password
    internal static let description2 = L10n.tr("Localizable", "sign_in_page.description2", fallback: "or sign in using email and password")
    /// Welcome back
    internal static let title = L10n.tr("Localizable", "sign_in_page.title", fallback: "Welcome back")
    internal enum Button {
      /// Sign in with e-mail
      internal static let signIn = L10n.tr("Localizable", "sign_in_page.button.sign_in", fallback: "Sign in with e-mail")
      /// You are new? Create an account.
      internal static let signUp = L10n.tr("Localizable", "sign_in_page.button.sign_up", fallback: "You are new? Create an account.")
    }
  }
  internal enum SignInWithAppleButton {
    /// Authorization failed: %s
    internal static func error(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "sign_in_with_apple_button.error", p1, fallback: "Authorization failed: %s")
    }
  }
  internal enum SignUpPage {
    /// Start using your new digital brain.
    internal static let description1 = L10n.tr("Localizable", "sign_up_page.description1", fallback: "Start using your new digital brain.")
    /// or sign up using email and password
    internal static let description2 = L10n.tr("Localizable", "sign_up_page.description2", fallback: "or sign up using email and password")
    /// Create an account
    internal static let title = L10n.tr("Localizable", "sign_up_page.title", fallback: "Create an account")
    internal enum Button {
      /// Already have an account? Sign in now.
      internal static let signIn = L10n.tr("Localizable", "sign_up_page.button.sign_in", fallback: "Already have an account? Sign in now.")
      /// Sign up with e-mail
      internal static let signUp = L10n.tr("Localizable", "sign_up_page.button.sign_up", fallback: "Sign up with e-mail")
    }
  }
  internal enum SubscriptionsPage {
    /// %@ Pro
    internal static func title(_ p1: Any) -> String {
      return L10n.tr("Localizable", "subscriptions_page.title", String(describing: p1), fallback: "%@ Pro")
    }
    internal enum Labels {
      /// • Payment will be charged to your iTunes account at confirmation of purchase and will automatically renew (at the duration/price selected) unless auto-renew is turned off at least 24 hrs before the end of the current period.
      internal static let legal1 = L10n.tr("Localizable", "subscriptions_page.labels.legal1", fallback: "• Payment will be charged to your iTunes account at confirmation of purchase and will automatically renew (at the duration/price selected) unless auto-renew is turned off at least 24 hrs before the end of the current period.")
      /// • Account will be charged for renewal within 24-hours prior to the end of the current period.
      internal static let legal2 = L10n.tr("Localizable", "subscriptions_page.labels.legal2", fallback: "• Account will be charged for renewal within 24-hours prior to the end of the current period.")
      /// • Current subscription may not be cancelled during the active subscription period; however, you can manage your subscription and/or turn off auto-renewal by visiting your iTunes Account Settings after purchase.
      internal static let legal3 = L10n.tr("Localizable", "subscriptions_page.labels.legal3", fallback: "• Current subscription may not be cancelled during the active subscription period; however, you can manage your subscription and/or turn off auto-renewal by visiting your iTunes Account Settings after purchase.")
      /// • Any unused portion of the free one month initial period will be forfeited when you purchases a subscription.
      internal static let legal4 = L10n.tr("Localizable", "subscriptions_page.labels.legal4", fallback: "• Any unused portion of the free one month initial period will be forfeited when you purchases a subscription.")
      /// • [Privacy Policy](%@) and [Terms and Conditions](%@) applied.
      internal static func legal5(_ p1: Any, _ p2: Any) -> String {
        return L10n.tr("Localizable", "subscriptions_page.labels.legal5", String(describing: p1), String(describing: p2), fallback: "• [Privacy Policy](%@) and [Terms and Conditions](%@) applied.")
      }
    }
  }
  internal enum UnverifiedEmailPage {
    /// Go to your %s inbox and confirm message from %s. After that, press button below.
    internal static func description1(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "unverified_email_page.description1", p1, p2, fallback: "Go to your %s inbox and confirm message from %s. After that, press button below.")
    }
    /// Didn't you receive a verification e-mail?
    internal static let description2 = L10n.tr("Localizable", "unverified_email_page.description2", fallback: "Didn't you receive a verification e-mail?")
    /// or
    internal static let description3 = L10n.tr("Localizable", "unverified_email_page.description3", fallback: "or")
    /// Email address verification needed
    internal static let title = L10n.tr("Localizable", "unverified_email_page.title", fallback: "Email address verification needed")
    internal enum Button {
      /// Send verification email
      internal static let send = L10n.tr("Localizable", "unverified_email_page.button.send", fallback: "Send verification email")
      /// Sign out
      internal static let signOut = L10n.tr("Localizable", "unverified_email_page.button.sign_out", fallback: "Sign out")
      /// Email verified
      internal static let verified = L10n.tr("Localizable", "unverified_email_page.button.verified", fallback: "Email verified")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
