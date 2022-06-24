import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/network.dart';
import '../../../domain_layer/models.dart';
import '../../../domain_layer/use_cases.dart';
import '../../cubits.dart';

/// Cubit that handles the states for the character details screen.
class CharacterDetailsCubit extends Cubit<CharacterDetailsState> {
  final random = Random();
  final GetEpisodesByIdsUseCase _getEpisodesByIdsUseCase;
  final GetCharactersByIdsUseCase _getCharactersByIdsUseCase;

  /// Creates a new [CharacterDetailsCubit].
  CharacterDetailsCubit({
    required Character character,
    required GetEpisodesByIdsUseCase getEpisodedByIdsUseCase,
    required GetCharactersByIdsUseCase getCharactersByIdsUseCase,
  })  : _getEpisodesByIdsUseCase = getEpisodedByIdsUseCase,
        _getCharactersByIdsUseCase = getCharactersByIdsUseCase,
        super(CharacterDetailsState(
          character: character,
        ));

  /// Gets the episodes related to the character.
  Future<void> getEpisodes() async {
    emit(
      state.copyWith(
          actions: state.actions.union({
            CharacterDetailsAction.episodes,
          }),
          errors: state.errors.difference(
            state.errors
                .where((element) =>
                    element.action == CharacterDetailsAction.episodes)
                .toSet(),
          )),
    );

    try {
      final episodes = await _getEpisodesByIdsUseCase(
        ids: state.character.episodeIds,
      );

      emit(
        state.copyWith(
          episodes: episodes,
          actions: state.actions.difference({
            CharacterDetailsAction.episodes,
          }),
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          actions: state.actions.difference({
            CharacterDetailsAction.episodes,
          }),
          errors: state.errors.union({
            CharacterDetailsError(
              action: CharacterDetailsAction.episodes,
              error: e.statusCode == null
                  ? CharacterDetailsErrorStatus.connectivity
                  : CharacterDetailsErrorStatus.generic,
            ),
          }),
        ),
      );
    }
  }

  /// Gets the related characters to the character.
  ///
  /// The [testIds] parameter is used for the unitary tests of the cubit.
  /// Must not be used on real scenarios.
  Future<void> getRelatedCharacters({
    List<int>? testIds,
  }) async {
    emit(
      state.copyWith(
          actions: state.actions.union({
            CharacterDetailsAction.relatedCharacters,
          }),
          errors: state.errors.difference(
            state.errors
                .where((element) =>
                    element.action == CharacterDetailsAction.relatedCharacters)
                .toSet(),
          )),
    );

    try {
      final relatedCharacters = await _getCharactersByIdsUseCase(
        ids: testIds ?? _generateRandomIds(),
      );

      emit(
        state.copyWith(
          relatedCharacters: relatedCharacters,
          actions: state.actions.difference({
            CharacterDetailsAction.relatedCharacters,
          }),
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          actions: state.actions.difference({
            CharacterDetailsAction.relatedCharacters,
          }),
          errors: state.errors.union({
            CharacterDetailsError(
              action: CharacterDetailsAction.relatedCharacters,
              error: e.statusCode == null
                  ? CharacterDetailsErrorStatus.connectivity
                  : CharacterDetailsErrorStatus.generic,
            ),
          }),
        ),
      );
    }
  }

  /// Generates a random id list.
  List<int> _generateRandomIds() {
    final randomIds = <int>{};
    while (randomIds.length < 3) {
      final id = random.nextInt(100);
      if (id > 0) {
        randomIds.add(id);
      }
    }

    return randomIds.toList();
  }
}
