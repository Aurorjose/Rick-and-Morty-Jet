import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../../../domain_layer/models.dart';

/// Model used for the errors.
class CharacterDetailsError extends Equatable {
  /// The action.
  final CharacterDetailsAction action;

  /// The error.
  final CharacterDetailsErrorStatus error;

  /// Creates a new [CharacterDetailsError].
  const CharacterDetailsError({
    required this.action,
    required this.error,
  });

  @override
  List<Object?> get props => [
        action,
        error,
      ];
}

/// The available error status.
enum CharacterDetailsErrorStatus {
  /// Connectivity.
  connectivity,

  /// Generic error.
  generic,
}

/// The available actions.
enum CharacterDetailsAction {
  /// Fetching episodes.
  episodes,

  /// Fetching related characters.
  relatedCharacters,
}

/// The state for the [CharacterDetailsCubit].
class CharacterDetailsState extends Equatable {
  /// The character response.
  final Character character;

  /// Whether if the cubit is busy or not.
  final bool busy;

  /// The actions that are being
  final UnmodifiableSetView<CharacterDetailsAction> actions;

  /// The errors.
  final UnmodifiableSetView<CharacterDetailsError> errors;

  /// The episodes that the character appears on.
  final UnmodifiableListView<Episode> episodes;

  /// The related characters to this character.
  final UnmodifiableListView<Character> relatedCharacters;

  /// Creates a new [CharacterDetailsState].
  CharacterDetailsState({
    required this.character,
    Set<CharacterDetailsAction> actions = const <CharacterDetailsAction>{},
    Set<CharacterDetailsError> errors = const <CharacterDetailsError>{},
    Iterable<Episode> episodes = const <Episode>[],
    Iterable<Character> relatedCharacters = const <Character>[],
  })  : actions = UnmodifiableSetView(actions),
        errors = UnmodifiableSetView(errors),
        episodes = UnmodifiableListView(episodes),
        relatedCharacters = UnmodifiableListView(relatedCharacters),
        busy = actions.isNotEmpty;

  /// Creates a copy of this state.
  CharacterDetailsState copyWith({
    CharacterResponse? characterResponse,
    Set<CharacterDetailsAction>? actions,
    Set<CharacterDetailsError>? errors,
    Iterable<Episode>? episodes,
    Iterable<Character>? relatedCharacters,
  }) =>
      CharacterDetailsState(
        character: character,
        actions: actions ?? this.actions,
        errors: errors ?? this.errors,
        episodes: episodes ?? this.episodes,
        relatedCharacters: relatedCharacters ?? this.relatedCharacters,
      );

  @override
  List<Object?> get props => [
        character,
        busy,
        actions,
        errors,
        episodes,
        relatedCharacters,
      ];
}
