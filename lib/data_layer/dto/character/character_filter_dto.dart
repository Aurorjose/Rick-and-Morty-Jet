import '../../dtos.dart';

/// Data transfer object representing the character filters.
class CharacterFilterDTO {
  /// The status.
  CharacterStatusDTO? status;

  /// The specie.
  CharacterSpeciesDTO? species;

  /// Creates a new [CharacterFilterDTO].
  CharacterFilterDTO({
    this.status,
    this.species,
  });
}
