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
    internal enum Button {
      /// Add
      internal static let add = L10n.tr("Localizable", "add_memory_page.button.add")
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
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "general.cancel")
    /// OK
    internal static let ok = L10n.tr("Localizable", "general.ok")
  }

  internal enum MemoriesPage {
    /// Memories
    internal static let title = L10n.tr("Localizable", "memories_page.title")
    internal enum Button {
      /// Add memory
      internal static let add = L10n.tr("Localizable", "memories_page.button.add")
    }
  }

  internal enum MemoryCell {
    internal enum ProcessingCell {
      /// Processing...
      internal static let title = L10n.tr("Localizable", "memory_cell.processing_cell.title")
    }
  }

  internal enum MemoryPage {
    /// Memory not found
    internal static let notFound = L10n.tr("Localizable", "memory_page.not_found")
    /// Open memory
    internal static let openMemory = L10n.tr("Localizable", "memory_page.open_memory")
    /// Memory
    internal static let title = L10n.tr("Localizable", "memory_page.title")
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
      /// Sign out
      internal static let signOut = L10n.tr("Localizable", "settings_page.button.sign_out")
    }
  }

  internal enum ShareExtension {
    /// Notes (optional)
    internal static let notesPlaceholder = L10n.tr("Localizable", "share_extension.notes_placeholder")
    /// Add
    internal static let primaryAction = L10n.tr("Localizable", "share_extension.primary_action")
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
