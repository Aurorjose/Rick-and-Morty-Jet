/// Convenience class for handling JSONs
class JsonParser {
  /// Parses a value into a [double].
  static double? parseDouble(num? value) => value?.toDouble();

  /// Parses a value into an [int].
  static int parseInt(num? value) => (value ?? 0).toInt();

  /// Parses a value into a [DateTime].
  static DateTime? parseDate(dynamic value) {
    if (value == null || value is! int) return null;
    return DateTime.fromMillisecondsSinceEpoch(value);
  }

  /// Parses a [String] into a [DateTime].
  static DateTime? parseStringDate(String? value) =>
      DateTime.tryParse(value ?? '');
}
