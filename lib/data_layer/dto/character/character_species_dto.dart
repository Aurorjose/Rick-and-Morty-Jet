import 'package:collection/collection.dart';

import '../../helpers.dart';

/// The data transfer object representing a character species.
class CharacterSpeciesDTO extends EnumDTO {
  /// Human
  static const human = CharacterSpeciesDTO._internal('Human');

  /// Alien
  static const alien = CharacterSpeciesDTO._internal('Alien');

  /// List of all possible character species.
  static const List<CharacterSpeciesDTO> values = [
    human,
    alien,
  ];

  const CharacterSpeciesDTO._internal(String value) : super.internal(value);

  /// Convert string to [CharacterSpeciesDTO].
  static CharacterSpeciesDTO? fromRaw(String? raw) => values.firstWhereOrNull(
        (val) => val.value == raw,
      );
}
