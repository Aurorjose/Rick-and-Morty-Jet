import 'package:rick_and_morty_jose_jet/features/characters.dart';

/// UI extension on the character gender.
extension CharacterGenderUIExtension on CharacterGender? {
  /// Localizes the gender.
  String get localize {
    switch (this) {
      case CharacterGender.male:
        return 'Male';

      case CharacterGender.female:
        return 'Female';

      case CharacterGender.unknown:
      default:
        return 'Unknown';
    }
  }
}

/// UI extension on the character species.
extension CharacterSpeciesUIExtension on CharacterSpecies? {
  /// Localizes the species.
  String get localize {
    switch (this) {
      case CharacterSpecies.human:
        return 'Human';

      case CharacterSpecies.alien:
        return 'Alien';

      default:
        return 'Unknown';
    }
  }
}

/// UI extension on the character status.
extension CharacterStatusUIExtension on CharacterStatus? {
  /// Localizes the species.
  String get localize {
    switch (this) {
      case CharacterStatus.alive:
        return 'Alive';

      case CharacterStatus.dead:
        return 'Dead';

      case CharacterStatus.unknown:
      default:
        return 'Unknown';
    }
  }
}
