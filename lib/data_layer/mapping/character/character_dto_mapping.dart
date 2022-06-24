import '../../../domain_layer/models.dart';
import '../../dtos.dart';
import '../../mappings.dart';

/// Mapping extensions on the [CharacterDTO].
extension CharacterDTOMapping on CharacterDTO {
  /// Maps a [CharacterDTO] into a [Character].
  Character toCharacter() => Character(
        id: id ?? 0,
        name: name ?? '',
        status: status?.toStatus(),
        species: species?.toSpecies(),
        type: type,
        gender: gender?.toGender(),
        origin: origin?.toLocation(),
        location: location?.toLocation(),
        imageURL: imageURL ?? '',
        episodeIds: episodeIds,
        url: url ?? '',
        created: created,
      );
}

/// Mapping extensions on the [CharacterResponseDTO].
extension CharacterResponseDTOMapping on CharacterResponseDTO {
  /// Maps a [CharacterResponseDTO] into a [CharacterResponse].
  CharacterResponse toCharacterResponse() => CharacterResponse(
        count: count,
        pages: pages,
        nextPage: nextPage,
        characters: characters?.map(
              (e) => e.toCharacter(),
            ) ??
            const <Character>[],
      );
}

/// Mapping extensions on the [CharacterStatusDTO].
extension CharacterStatusDTOMapping on CharacterStatusDTO {
  /// Maps a [CharacterStatusDTO] into a [CharacterStatus].
  CharacterStatus? toStatus() {
    switch (this) {
      case CharacterStatusDTO.alive:
        return CharacterStatus.alive;

      case CharacterStatusDTO.dead:
        return CharacterStatus.dead;

      case CharacterStatusDTO.unknown:
        return CharacterStatus.unknown;

      default:
        return null;
    }
  }
}

/// Mapping extensions on the [CharacterSpeciesDTO].
extension CharacterSpeciesDTOMapping on CharacterSpeciesDTO {
  /// Maps a [CharacterSpeciesDTO] into a [CharacterSpecies].
  CharacterSpecies? toSpecies() {
    switch (this) {
      case CharacterSpeciesDTO.alien:
        return CharacterSpecies.alien;

      case CharacterSpeciesDTO.human:
        return CharacterSpecies.human;

      default:
        return null;
    }
  }
}

/// Mapping extensions on the [CharacterGenderDTO].
extension CharacterGenderDTOMapping on CharacterGenderDTO {
  /// Maps a [CharacterGenderDTO] into a [CharacterGender].
  CharacterGender? toGender() {
    switch (this) {
      case CharacterGenderDTO.male:
        return CharacterGender.male;

      case CharacterGenderDTO.female:
        return CharacterGender.female;

      case CharacterGenderDTO.unknown:
        return CharacterGender.unknown;

      default:
        return null;
    }
  }
}

/// Mapping extensions on the [CharacterFilter].
extension CharacterFilterMapping on CharacterFilter {
  /// Maps a [CharacterFilter] into a [CharacterFilterDTO].
  CharacterFilterDTO toDTO() => CharacterFilterDTO(
        status: status?.toDTO(),
        species: species?.toDTO(),
      );
}

/// Mapping extensions on the [CharacterSpecies].
extension CharacterSpeciesMapping on CharacterSpecies {
  /// Maps a [CharacterSpecies] into a [CharacterSpeciesDTO].
  CharacterSpeciesDTO? toDTO() {
    switch (this) {
      case CharacterSpecies.alien:
        return CharacterSpeciesDTO.alien;

      case CharacterSpecies.human:
        return CharacterSpeciesDTO.human;

      default:
        return null;
    }
  }
}

/// Mapping extensions on the [CharacterStatus].
extension CharacterStatusMapping on CharacterStatus {
  /// Maps a [CharacterStatus] into a [CharacterStatusDTO].
  CharacterStatusDTO? toDTO() {
    switch (this) {
      case CharacterStatus.alive:
        return CharacterStatusDTO.alive;

      case CharacterStatus.dead:
        return CharacterStatusDTO.dead;

      case CharacterStatus.unknown:
        return CharacterStatusDTO.unknown;

      default:
        return null;
    }
  }
}
