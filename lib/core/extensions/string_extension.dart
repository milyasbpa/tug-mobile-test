extension StringX on String {
  // 'hello world' → 'Hello world'
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  // 'hello world' → 'Hello World'
  String get titleCase => split(' ').map((w) => w.capitalized).join(' ');

  bool get isValidEmail => RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(this);

  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  String? get nullIfEmpty => isEmpty ? null : this;
}
