import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_jose_jet/data_layer/network.dart';
import 'package:rick_and_morty_jose_jet/features/characters.dart';
import 'package:rick_and_morty_jose_jet/features/episodes.dart';
import 'package:test/test.dart';

class MockGetCharactersByIdsUseCase extends Mock
    implements GetCharactersByIdsUseCase {}

class MockGetEpisodesByIdsUseCase extends Mock
    implements GetEpisodesByIdsUseCase {}

class MockCharacter extends Mock implements Character {}

class MockEpisode extends Mock implements Episode {}

final _charactersUseCase = MockGetCharactersByIdsUseCase();
final _episodesUseCase = MockGetEpisodesByIdsUseCase();

final defaultCharacter = Character(
  id: 1,
  imageURL: '',
  name: '',
  type: '',
  url: '',
);

const _successIds = [1, 2];
const _connectivityErrorIds = [3, 4];
const _genericErrorIds = [5, 6];

final _mockCharacterList = List.generate(
  2,
  (index) => MockCharacter(),
);
final _mockEpisodeList = List.generate(
  2,
  (index) => MockEpisode(),
);

const _connectivityException = NetworkException();
const _genericException = NetworkException(statusCode: 400);

void main() {
  EquatableConfig.stringify = true;

  setUpAll(() {
    when(
      () => _charactersUseCase(
        ids: _successIds,
      ),
    ).thenAnswer(
      (_) async => _mockCharacterList,
    );

    when(
      () => _charactersUseCase(
        ids: _connectivityErrorIds,
      ),
    ).thenThrow(_connectivityException);

    when(
      () => _charactersUseCase(
        ids: _genericErrorIds,
      ),
    ).thenThrow(_genericException);

    when(
      () => _episodesUseCase(
        ids: _successIds,
      ),
    ).thenAnswer(
      (_) async => _mockEpisodeList,
    );

    when(
      () => _episodesUseCase(
        ids: _connectivityErrorIds,
      ),
    ).thenThrow(_connectivityException);

    when(
      () => _episodesUseCase(
        ids: _genericErrorIds,
      ),
    ).thenThrow(_genericException);
  });

  group(
    'CharacterDetailsCubit episodes |',
    () {
      final succesCharacter = defaultCharacter.copyWith(
        episodeIds: _successIds,
      );

      final defaultSuccessState = CharacterDetailsState(
        character: succesCharacter,
      );

      blocTest<CharacterDetailsCubit, CharacterDetailsState>(
        'Successfully request the episodes',
        build: () => CharacterDetailsCubit(
          character: succesCharacter,
          getCharactersByIdsUseCase: _charactersUseCase,
          getEpisodedByIdsUseCase: _episodesUseCase,
        ),
        act: (c) => c.getEpisodes(),
        expect: () => [
          defaultSuccessState.copyWith(actions: {
            CharacterDetailsAction.episodes,
          }),
          defaultSuccessState.copyWith(
            episodes: _mockEpisodeList,
          ),
        ],
        verify: (c) {
          verify(
            () => _episodesUseCase(
              ids: _successIds,
            ),
          ).called(1);
        },
      );

      final connectivityCharacter = defaultCharacter.copyWith(
        episodeIds: _connectivityErrorIds,
      );

      final defaultConnectivityState = CharacterDetailsState(
        character: connectivityCharacter,
      );

      blocTest<CharacterDetailsCubit, CharacterDetailsState>(
        'Connectivity error when requesting the episodes',
        build: () => CharacterDetailsCubit(
          character: connectivityCharacter,
          getCharactersByIdsUseCase: _charactersUseCase,
          getEpisodedByIdsUseCase: _episodesUseCase,
        ),
        act: (c) => c.getEpisodes(),
        expect: () => [
          defaultConnectivityState.copyWith(actions: {
            CharacterDetailsAction.episodes,
          }),
          defaultConnectivityState.copyWith(
            errors: {
              const CharacterDetailsError(
                action: CharacterDetailsAction.episodes,
                error: CharacterDetailsErrorStatus.connectivity,
              )
            },
          ),
        ],
        verify: (c) {
          verify(
            () => _episodesUseCase(
              ids: _connectivityErrorIds,
            ),
          ).called(1);
        },
      );

      final genericCharacter = defaultCharacter.copyWith(
        episodeIds: _genericErrorIds,
      );

      final defaultGenericState = CharacterDetailsState(
        character: genericCharacter,
      );

      blocTest<CharacterDetailsCubit, CharacterDetailsState>(
        'Generic error when requesting the episodes',
        build: () => CharacterDetailsCubit(
          character: genericCharacter,
          getCharactersByIdsUseCase: _charactersUseCase,
          getEpisodedByIdsUseCase: _episodesUseCase,
        ),
        act: (c) => c.getEpisodes(),
        expect: () => [
          defaultGenericState.copyWith(actions: {
            CharacterDetailsAction.episodes,
          }),
          defaultGenericState.copyWith(
            errors: {
              const CharacterDetailsError(
                action: CharacterDetailsAction.episodes,
                error: CharacterDetailsErrorStatus.generic,
              )
            },
          ),
        ],
        verify: (c) {
          verify(
            () => _episodesUseCase(
              ids: _genericErrorIds,
            ),
          ).called(1);
        },
      );

      final autoClearErrorState = defaultConnectivityState.copyWith(
        errors: {
          const CharacterDetailsError(
            action: CharacterDetailsAction.episodes,
            error: CharacterDetailsErrorStatus.connectivity,
          )
        },
      );

      blocTest<CharacterDetailsCubit, CharacterDetailsState>(
        'Automatically clears errors when retrying',
        build: () => CharacterDetailsCubit(
          character: connectivityCharacter,
          getCharactersByIdsUseCase: _charactersUseCase,
          getEpisodedByIdsUseCase: _episodesUseCase,
        ),
        act: (c) => c.getEpisodes(),
        expect: () => [
          autoClearErrorState.copyWith(
            actions: {
              CharacterDetailsAction.episodes,
            },
            errors: {},
          ),
          autoClearErrorState.copyWith(
            errors: {
              const CharacterDetailsError(
                action: CharacterDetailsAction.episodes,
                error: CharacterDetailsErrorStatus.connectivity,
              )
            },
          ),
        ],
        verify: (c) {
          verify(
            () => _episodesUseCase(
              ids: _connectivityErrorIds,
            ),
          ).called(1);
        },
      );
    },
  );

  group(
    'CharacterDetailsCubit characters |',
    () {
      final defaultState = CharacterDetailsState(
        character: defaultCharacter,
      );

      blocTest<CharacterDetailsCubit, CharacterDetailsState>(
        'Successfully request the related characters',
        build: () => CharacterDetailsCubit(
          character: defaultCharacter,
          getCharactersByIdsUseCase: _charactersUseCase,
          getEpisodedByIdsUseCase: _episodesUseCase,
        ),
        act: (c) => c.getRelatedCharacters(
          testIds: _successIds,
        ),
        expect: () => [
          defaultState.copyWith(actions: {
            CharacterDetailsAction.relatedCharacters,
          }),
          defaultState.copyWith(
            relatedCharacters: _mockCharacterList,
          ),
        ],
        verify: (c) {
          verify(
            () => _charactersUseCase(
              ids: _successIds,
            ),
          ).called(1);
        },
      );

      blocTest<CharacterDetailsCubit, CharacterDetailsState>(
        'Connectivity error when requesting the related characters',
        build: () => CharacterDetailsCubit(
          character: defaultCharacter,
          getCharactersByIdsUseCase: _charactersUseCase,
          getEpisodedByIdsUseCase: _episodesUseCase,
        ),
        act: (c) => c.getRelatedCharacters(
          testIds: _connectivityErrorIds,
        ),
        expect: () => [
          defaultState.copyWith(actions: {
            CharacterDetailsAction.relatedCharacters,
          }),
          defaultState.copyWith(
            errors: {
              const CharacterDetailsError(
                action: CharacterDetailsAction.relatedCharacters,
                error: CharacterDetailsErrorStatus.connectivity,
              )
            },
          ),
        ],
        verify: (c) {
          verify(
            () => _charactersUseCase(
              ids: _connectivityErrorIds,
            ),
          ).called(1);
        },
      );

      blocTest<CharacterDetailsCubit, CharacterDetailsState>(
        'Generic error when requesting the related characters',
        build: () => CharacterDetailsCubit(
          character: defaultCharacter,
          getCharactersByIdsUseCase: _charactersUseCase,
          getEpisodedByIdsUseCase: _episodesUseCase,
        ),
        act: (c) => c.getRelatedCharacters(
          testIds: _genericErrorIds,
        ),
        expect: () => [
          defaultState.copyWith(actions: {
            CharacterDetailsAction.relatedCharacters,
          }),
          defaultState.copyWith(
            errors: {
              const CharacterDetailsError(
                action: CharacterDetailsAction.relatedCharacters,
                error: CharacterDetailsErrorStatus.generic,
              )
            },
          ),
        ],
        verify: (c) {
          verify(
            () => _charactersUseCase(
              ids: _genericErrorIds,
            ),
          ).called(1);
        },
      );

      final autoClearErrorState = defaultState.copyWith(
        errors: {
          const CharacterDetailsError(
            action: CharacterDetailsAction.relatedCharacters,
            error: CharacterDetailsErrorStatus.connectivity,
          )
        },
      );

      blocTest<CharacterDetailsCubit, CharacterDetailsState>(
        'Automatically clears errors when retrying',
        build: () => CharacterDetailsCubit(
          character: defaultCharacter,
          getCharactersByIdsUseCase: _charactersUseCase,
          getEpisodedByIdsUseCase: _episodesUseCase,
        ),
        act: (c) => c.getRelatedCharacters(
          testIds: _connectivityErrorIds,
        ),
        expect: () => [
          autoClearErrorState.copyWith(
            actions: {
              CharacterDetailsAction.relatedCharacters,
            },
            errors: {},
          ),
          autoClearErrorState.copyWith(
            errors: {
              const CharacterDetailsError(
                action: CharacterDetailsAction.relatedCharacters,
                error: CharacterDetailsErrorStatus.connectivity,
              )
            },
          ),
        ],
        verify: (c) {
          verify(
            () => _charactersUseCase(
              ids: _connectivityErrorIds,
            ),
          ).called(1);
        },
      );
    },
  );
}
