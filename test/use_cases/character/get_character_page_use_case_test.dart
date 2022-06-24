import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_jose_jet/features/characters.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterRepository extends Mock
    implements CharacterRepositoryInterface {}

class MockCharacterResponse extends Mock implements CharacterResponse {}

late MockCharacterRepository _repository;
late GetCharacterPageUseCase _useCase;
late MockCharacterResponse _mockCharacterResponse;

const _page = 1;

void main() {
  setUp(() {
    _repository = MockCharacterRepository();
    _useCase = GetCharacterPageUseCase(repository: _repository);

    _mockCharacterResponse = MockCharacterResponse();

    when(
      () => _repository.list(
        page: any(named: 'page'),
      ),
    ).thenAnswer((_) async => _mockCharacterResponse);
  });

  test('Should return a list of characters related to a page', () async {
    final result = await _useCase(
      page: _page,
    );

    expect(result, _mockCharacterResponse);

    verify(
      () => _repository.list(
        page: _page,
      ),
    ).called(1);
  });
}
