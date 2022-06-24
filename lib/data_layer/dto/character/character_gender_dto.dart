import 'package:collection/collection.dart';

import '../../helpers.dart';

/// The data transfer object representing a character gender
class CharacterGenderDTO extends EnumDTO {
  /// Male
  static const male = CharacterGenderDTO._internal('Male');

  /// Female
  static const female = CharacterGenderDTO._internal('Female');

  /// Unknown
  static const unknown = CharacterGenderDTO._internal('Unknown');

  /// List of all possible character genders.
  static const List<CharacterGenderDTO> values = [
    male,
    female,
    unknown,
  ];

  const CharacterGenderDTO._internal(String value) : super.internal(value);

  /// Convert string to [CharacterGenderDTO]
  static CharacterGenderDTO? fromRaw(String? raw) => values.firstWhereOrNull(
        (val) => val.value == raw,
      );
}
