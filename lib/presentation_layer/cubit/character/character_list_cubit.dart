import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/network.dart';
import '../../../domain_layer/models.dart';
import '../../../domain_layer/use_cases.dart';
import '../../cubits.dart';

/// Cubit for the character list screen.
class CharacterListCubit extends Cubit<CharacterListState> {
  final GetCharacterPageUseCase _getCharacterPageUseCase;

  /// Creates a new [CharacterListCubit].
  CharacterListCubit({
    required GetCharacterPageUseCase getCharacterPageUseCase,
  })  : _getCharacterPageUseCase = getCharacterPageUseCase,
        super(
          const CharacterListState(),
        );

  /// Updates the filter details. If the passed filter details are different
  /// from the current ones, the character list is refreshed.
  Future<void> updateFilterDetails({
    String query = '',
    CharacterFilter? filter,
  }) async {
    if (state.query != query || state.filter != filter) {
      emit(
        state.copyWith(
          query: query,
          filter: filter,
          characterResponse: state.characterResponse?.copyWith(characters: []),
        ),
      );

      await list();
    }
  }

  /// Loads a list of characters.
  Future<void> list({
    bool loadMore = false,
  }) async {
    if (state.characterResponse == null ||
        state.characterResponse?.nextPage != null ||
        !loadMore) {
      emit(
        state.copyWith(
          busy: true,
        ),
      );

      try {
        final characterResponse = await _getCharacterPageUseCase(
          page: state.characterResponse == null || !loadMore
              ? 1
              : state.characterResponse!.nextPage!,
          query: state.query,
          filter: state.filter,
        );

        emit(
          state.copyWith(
            busy: false,
            characterResponse: state.characterResponse == null || !loadMore
                ? characterResponse
                : state.characterResponse!.copyWith(
                    nextPage: characterResponse.nextPage,
                    characters: [
                      ...state.characterResponse!.characters,
                      ...characterResponse.characters,
                    ],
                  ),
          ),
        );
      } on NetworkException catch (e) {
        emit(
          state.copyWith(
            busy: false,
            characterResponse: e.statusCode == 404
                ? state.characterResponse?.copyWith(characters: [])
                : state.characterResponse,
            errorStatus: e.statusCode == null
                ? CharacterListErrorStatus.connectivity
                : e.statusCode == 404
                    ? CharacterListErrorStatus.notFound
                    : CharacterListErrorStatus.generic,
          ),
        );
      }
    }
  }
}
