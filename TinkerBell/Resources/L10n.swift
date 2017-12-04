// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length

// swiftlint:disable identifier_name line_length type_body_length
enum L10n {
  /// %@分前
  static func beforeMinutes(_ p1: String) -> String {
    return L10n.tr("Localizable", "Before minutes", p1)
  }
  /// キャンセル
  static let cancel = L10n.tr("Localizable", "Cancel")
  /// いってらっしゃい！今日も1日頑張りましょう🎉
  static let cheerMessage = L10n.tr("Localizable", "Cheer message")
  /// 出発まであと%@分です
  static func countdownAlert(_ p1: String) -> String {
    return L10n.tr("Localizable", "Countdown alert", p1)
  }
  /// 削除する
  static let delete = L10n.tr("Localizable", "Delete")
  /// アラームを削除します。よろしいですか？
  static let deleteAlarmAlert = L10n.tr("Localizable", "Delete alarm alert")
  /// Depature Time
  static let departureTime = L10n.tr("Localizable", "DepartureTime")
  /// 出発の時間です！
  static let depatureAlert = L10n.tr("Localizable", "DepatureAlert")
  /// Next
  static let next = L10n.tr("Localizable", "Next")
  /// Unset
  static let noDepatureTime = L10n.tr("Localizable", "No depature time")
  /// 出発時間が設定されていません🤔
  static let notDepatureTimeAlert = L10n.tr("Localizable", "NotDepatureTimeAlert")
  /// Save
  static let save = L10n.tr("Localizable", "Save")
  /// Please set \ndepature time!
  static let setDepatureTime = L10n.tr("Localizable", "Set depature time")
  /// おっと
  static let uhOh = L10n.tr("Localizable", "Uh-oh")
}
// swiftlint:enable identifier_name line_length type_body_length

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
