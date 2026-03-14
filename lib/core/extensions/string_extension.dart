/// Extension on [String] — common helpers used throughout the app.
extension StringX on String {
  /// Capitalises only the first character.
  /// `'hello world'` → `'Hello world'`
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Title-cases every word.
  /// `'hello world'` → `'Hello World'`
  String get titleCase => split(' ').map((w) => w.capitalized).join(' ');

  /// Returns true if the string is a valid email address.
  bool get isValidEmail => RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(this);

  /// Returns true if the string contains only digits.
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  /// Returns null if the string is empty, otherwise returns itself.
  String? get nullIfEmpty => isEmpty ? null : this;
}
