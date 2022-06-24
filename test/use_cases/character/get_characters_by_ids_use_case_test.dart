import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_jose_jet/features/characters.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterRepository extends Mock
    implements CharacterRepositoryInterface {}

class MockCharacter extends Mock implements Character {}

late MockCharacterRepository _repository;
late GetCharactersByIdsUseCase _useCase;
late List<MockCharacter> _mockCharacterList;

final _ids = [1, 2, 3, 4, 5];

void main() {
  setUp(() {
    _repository = MockCharacterRepository();
    _useCase = GetCharactersByIdsUseCase(repository: _repository);

    _mockCharacterList = List.generate(
      5,
      (_) => MockCharacter(),
    );

    when(
      () => _repository.get(
        ids: any(named: 'ids'),
      ),
    ).thenAnswer((_) async => _mockCharacterList);
  });

  test('Should return a list of characters', () async {
    final result = await _useCase(
      ids: _ids,
    );

    expect(result, _mockCharacterList);

    verify(
      () => _repository.get(
        ids: _ids,
      ),
    ).called(1);
  });
}
