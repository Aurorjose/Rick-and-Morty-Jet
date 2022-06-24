import 'package:collection/collection.dart';

import '../../helpers.dart';

/// The data transfer object representing a character status.
class CharacterStatusDTO extends EnumDTO {
  /// Alive
  static const alive = CharacterStatusDTO._internal('Alive');

  /// Dead
  static const dead = CharacterStatusDTO._internal('Dead');

  /// Unknown
  static const unknown = CharacterStatusDTO._internal('Unknown');

  /// List of all possible character statuses.
  static const List<CharacterStatusDTO> values = [
    alive,
    dead,
    unknown,
  ];

  const CharacterStatusDTO._internal(String value) : super.internal(value);

  /// Convert string to [CharacterStatusDTO]
  static CharacterStatusDTO? fromRaw(String? raw) => values.firstWhereOrNull(
        (val) => val.value == raw,
      );
}
