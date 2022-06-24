import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../../models.dart';

/// The available character status.
enum CharacterStatus {
  /// Alive.
  alive,

  /// Dead,
  dead,

  /// unknown,
  unknown,
}

/// The available character species.
enum CharacterSpecies {
  /// Human.
  human,

  /// Alien.
  alien,
}

/// The available character genders.
enum CharacterGender {
  /// Male.
  male,

  /// Female.
  female,

  /// Unknown.
  unknown,
}

/// The character model.
class Character extends Equatable {
  /// The id.
  final int id;

  /// The name.
  final String name;

  /// The status.
  final CharacterStatus? status;

  /// The species.
  final CharacterSpecies? species;

  /// The type or subespecies.
  final String? type;

  /// The gender.
  final CharacterGender? gender;

  /// The origin location.
  final Location? origin;

  /// The last known location.
  final Location? location;

  /// Link to the character's image. All images are 300x300px and most are
  /// medium shots or portraits since they are intended to be used as avatars.
  final String imageURL;

  /// The list of episode ids related to this character.
  final UnmodifiableListView<int> episodeIds;

  /// The character's own URL endpoint.
  final String url;

  /// Time at which the character was created in the database.
  final DateTime? created;

  /// Creates a new [Character].
  Character({
    required this.id,
    required this.name,
    this.status,
    this.species,
    required this.type,
    this.gender,
    this.origin,
    this.location,
    required this.imageURL,
    Iterable<int>? episodeIds,
    required this.url,
    this.created,
  }) : episodeIds = UnmodifiableListView(
          episodeIds ?? <int>[],
        );

  /// Creates a copy of this character.
  Character copyWith({
    int? id,
    String? name,
    String? type,
    String? imageURL,
    Iterable<int>? episodeIds,
    String? url,
  }) =>
      Character(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        imageURL: imageURL ?? this.imageURL,
        episodeIds: episodeIds ?? this.episodeIds,
        url: url ?? this.url,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        imageURL,
        episodeIds,
        url,
        created,
      ];
}
