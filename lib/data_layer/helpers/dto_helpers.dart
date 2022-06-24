import 'package:collection/collection.dart';

/// Returns true if [s] is either null or empty.
bool isEmpty(String? s) => s == null || s.isEmpty || s == 'null';

/// Returns true if [s] is a not null or empty string.
bool isNotEmpty(String? s) => s != null && s.isNotEmpty && s != 'null';

/// Returns the string with the first character capitalized
String capitalize(String? str) => str!.splitMapJoin(RegExp(r'\w+'),
    onMatch: (m) =>
        '${m.group(0)}'.substring(0, 1).toUpperCase() +
        '${m.group(0)}'.substring(1).toLowerCase(),
    onNonMatch: (n) => ' ');

/// Takes in two inputs [value1] and [value2]
/// returns true if all elements in value1 separated by a comma
/// are the same elements in value2
bool compareCommaSeparatedElements(String? value1, String? value2) {
  if (value1 == value2) return true;
  var cleanedValue1 = value1?.toUpperCase();
  var cleanedValue2 = value2?.toUpperCase();
  return const DeepCollectionEquality.unordered()
      .equals(cleanedValue1?.split(','), cleanedValue2?.split(','));
}
