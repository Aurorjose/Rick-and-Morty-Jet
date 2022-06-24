import 'package:equatable/equatable.dart';

import '../../../domain_layer/models.dart';

/// The available error status.
enum CharacterListErrorStatus {
  /// None.
  none,

  /// Connectivity.
  connectivity,

  /// Generic error.
  generic,

  /// Not found.
  notFound,
}

/// The state for the [CharacterListCubit].
class CharacterListState extends Equatable {
  /// The character response.
  final CharacterResponse? characterResponse;

  /// Whether if the cubit is busy or not.
  final bool busy;

  /// The error status.
  final CharacterListErrorStatus errorStatus;

  /// The query for filtering the characters.
  final String query;

  /// The character filter.
  final CharacterFilter? filter;

  /// Creates a new [CharacterListState].
  const CharacterListState({
    this.characterResponse,
    this.busy = false,
    this.errorStatus = CharacterListErrorStatus.none,
    this.query = '',
    this.filter,
  });

  /// Creates a copy of this state.
  CharacterListState copyWith({
    CharacterResponse? characterResponse,
    bool? busy,
    CharacterListErrorStatus? errorStatus,
    String? query,
    CharacterFilter? filter,
  }) =>
      CharacterListState(
        characterResponse: characterResponse ?? this.characterResponse,
        busy: busy ?? this.busy,
        errorStatus: (busy ?? false)
            ? CharacterListErrorStatus.none
            : errorStatus ?? this.errorStatus,
        query: query ?? this.query,
        filter: filter ?? this.filter,
      );

  @override
  List<Object?> get props => [
        characterResponse,
        busy,
        errorStatus,
        query,
        filter,
      ];
}
