import 'package:equatable/equatable.dart';

import '../../models.dart';

/// The model for the character filter.
class CharacterFilter extends Equatable {
  /// The status.
  final CharacterStatus? status;

  /// The species.
  final CharacterSpecies? species;

  /// Creates a new [CharacterFilter].
  const CharacterFilter({
    this.status,
    this.species,
  });

  /// Creates a copy of this character filter.
  CharacterFilter copyWith({
    CharacterStatus? status,
    CharacterSpecies? species,
  }) =>
      CharacterFilter(
        status: status ?? this.status,
        species: species ?? this.species,
      );

  @override
  List<Object?> get props => [
        status,
        species,
      ];
}
