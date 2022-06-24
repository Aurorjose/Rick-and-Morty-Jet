import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_jose_jet/data_layer/network.dart';
import 'package:rick_and_morty_jose_jet/features/characters.dart';
import 'package:test/test.dart';

class MockGetCharacterPageUseCase extends Mock
    implements GetCharacterPageUseCase {}

final _useCase = MockGetCharacterPageUseCase();

const _sucessPageId = 1;

final _firstPageCharacterPageResponse = CharacterResponse(nextPage: 2);
final _characterResponse = CharacterResponse();

const _connectivityErrorPageId = 3;
const _genericErrorPageId = 4;

const _successFilterDetails = CharacterFilter();
const _notFoundErrorFilterDetails = CharacterFilter(
  species: CharacterSpecies.alien,
);

const _connectivityException = NetworkException();
const _genericException = NetworkException(statusCode: 400);
const _notFoundException = NetworkException(statusCode: 404);

void main() {
  EquatableConfig.stringify = true;

  setUpAll(() {
    when(
      () => _useCase(
        page: _sucessPageId,
        query: any(named: 'query'),
        filter: any(named: 'filter'),
      ),
    ).thenAnswer(
      (_) async => _firstPageCharacterPageResponse,
    );

    when(
      () => _useCase(
        page: _firstPageCharacterPageResponse.nextPage!,
        query: any(named: 'query'),
        filter: any(named: 'filter'),
      ),
    ).thenAnswer(
      (_) async => _characterResponse,
    );

    when(
      () => _useCase(
        page: _connectivityErrorPageId,
        query: any(named: 'query'),
        filter: any(named: 'filter'),
      ),
    ).thenThrow(_connectivityException);

    when(
      () => _useCase(
        page: _genericErrorPageId,
        query: any(named: 'query'),
        filter: any(named: 'filter'),
      ),
    ).thenThrow(_genericException);

    when(
      () => _useCase(
        page: any(named: 'page'),
        query: any(named: 'query'),
        filter: _successFilterDetails,
      ),
    ).thenAnswer(
      (_) async => _characterResponse,
    );

    when(
      () => _useCase(
        page: any(named: 'page'),
        query: any(named: 'query'),
        filter: _notFoundErrorFilterDetails,
      ),
    ).thenThrow(_notFoundException);
  });

  group(
    'CharacterListCubit check error clears automatically |',
    () {
      const defaultState = CharacterListState(
        busy: false,
        errorStatus: CharacterListErrorStatus.generic,
      );

      blocTest<CharacterListCubit, CharacterListState>(
        'Automatically clears errors when retrying',
        build: () => CharacterListCubit(
          getCharacterPageUseCase: _useCase,
        ),
        seed: () => defaultState,
        act: (c) => c.list(),
        expect: () => [
          defaultState.copyWith(
            busy: true,
            errorStatus: CharacterListErrorStatus.none,
          ),
          defaultState.copyWith(
            characterResponse: _firstPageCharacterPageResponse,
            errorStatus: CharacterListErrorStatus.none,
          ),
        ],
        verify: (c) {
          verify(
            () => _useCase(
              page: _sucessPageId,
            ),
          ).called(1);
        },
      );
    },
  );

  group(
    'CharacterListCubit pagination |',
    () {
      const defaultState = CharacterListState(
        busy: false,
        errorStatus: CharacterListErrorStatus.none,
      );

      blocTest<CharacterListCubit, CharacterListState>(
        'Successfully request first page',
        build: () => CharacterListCubit(
          getCharacterPageUseCase: _useCase,
        ),
        act: (c) => c.list(),
        expect: () => [
          defaultState.copyWith(busy: true),
          defaultState.copyWith(
            characterResponse: _firstPageCharacterPageResponse,
          ),
        ],
        verify: (c) {
          verify(
            () => _useCase(
              page: _sucessPageId,
            ),
          ).called(1);
        },
      );

      final nextPageDefaultState = CharacterListState(
        busy: false,
        errorStatus: CharacterListErrorStatus.none,
        characterResponse: _firstPageCharacterPageResponse,
      );

      blocTest<CharacterListCubit, CharacterListState>(
        'Successfully request next page',
        build: () => CharacterListCubit(
          getCharacterPageUseCase: _useCase,
        ),
        seed: () => nextPageDefaultState,
        act: (c) => c.list(loadMore: true),
        expect: () => [
          nextPageDefaultState.copyWith(busy: true),
          nextPageDefaultState.copyWith(
            characterResponse: _characterResponse,
          ),
        ],
        verify: (c) {
          verify(
            () => _useCase(
              page: _firstPageCharacterPageResponse.nextPage!,
            ),
          ).called(1);
        },
      );
    },
  );

  group(
    'CharacterListCubit filtering |',
    () {
      const defaultSuccessState = CharacterListState(
        busy: false,
        errorStatus: CharacterListErrorStatus.none,
        filter: _successFilterDetails,
      );

      blocTest<CharacterListCubit, CharacterListState>(
        'Successfully filtered',
        build: () => CharacterListCubit(
          getCharacterPageUseCase: _useCase,
        ),
        seed: () => defaultSuccessState,
        act: (c) => c.list(),
        expect: () => [
          defaultSuccessState.copyWith(busy: true),
          defaultSuccessState.copyWith(
            characterResponse: _characterResponse,
          ),
        ],
        verify: (c) {
          verify(
            () => _useCase(
              page: 1,
              filter: _successFilterDetails,
            ),
          ).called(1);
        },
      );

      const defaultNotFoundState = CharacterListState(
        busy: false,
        errorStatus: CharacterListErrorStatus.none,
        filter: _notFoundErrorFilterDetails,
      );

      blocTest<CharacterListCubit, CharacterListState>(
        'Filter returns not found error',
        build: () => CharacterListCubit(
          getCharacterPageUseCase: _useCase,
        ),
        seed: () => defaultNotFoundState,
        act: (c) => c.list(),
        expect: () => [
          defaultNotFoundState.copyWith(busy: true),
          defaultNotFoundState.copyWith(
            errorStatus: CharacterListErrorStatus.notFound,
          ),
        ],
        verify: (c) {
          verify(
            () => _useCase(
              page: 1,
              filter: _notFoundErrorFilterDetails,
            ),
          ).called(1);
        },
      );
    },
  );

  group(
    'CharacterListCubit error handling |',
    () {
      final defaultConnectivityState = CharacterListState(
        busy: false,
        errorStatus: CharacterListErrorStatus.none,
        characterResponse: CharacterResponse(
          nextPage: _connectivityErrorPageId,
        ),
      );

      blocTest<CharacterListCubit, CharacterListState>(
        'Connectivity error',
        build: () => CharacterListCubit(
          getCharacterPageUseCase: _useCase,
        ),
        seed: () => defaultConnectivityState,
        act: (c) => c.list(loadMore: true),
        expect: () => [
          defaultConnectivityState.copyWith(busy: true),
          defaultConnectivityState.copyWith(
            errorStatus: CharacterListErrorStatus.connectivity,
          ),
        ],
        verify: (c) {
          verify(
            () => _useCase(
              page: _connectivityErrorPageId,
            ),
          ).called(1);
        },
      );

      final defaultGenericState = CharacterListState(
        busy: false,
        errorStatus: CharacterListErrorStatus.none,
        characterResponse: CharacterResponse(
          nextPage: _genericErrorPageId,
        ),
      );

      blocTest<CharacterListCubit, CharacterListState>(
        'Generic error',
        build: () => CharacterListCubit(
          getCharacterPageUseCase: _useCase,
        ),
        seed: () => defaultGenericState,
        act: (c) => c.list(loadMore: true),
        expect: () => [
          defaultGenericState.copyWith(busy: true),
          defaultGenericState.copyWith(
            errorStatus: CharacterListErrorStatus.generic,
          ),
        ],
        verify: (c) {
          verify(
            () => _useCase(
              page: _genericErrorPageId,
            ),
          ).called(1);
        },
      );
    },
  );
}
