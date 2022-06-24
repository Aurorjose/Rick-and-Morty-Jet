import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_jose_jet/features/episodes.dart';
import 'package:mocktail/mocktail.dart';

class MockEpisodeRepository extends Mock implements EpisodeRepositoryInterface {
}

class MockEpisode extends Mock implements Episode {}

late MockEpisodeRepository _repository;
late GetEpisodesByIdsUseCase _useCase;
late List<MockEpisode> _mockEpisodeList;

final _ids = [1, 2, 3, 4, 5];

void main() {
  setUp(() {
    _repository = MockEpisodeRepository();
    _useCase = GetEpisodesByIdsUseCase(repository: _repository);

    _mockEpisodeList = List.generate(
      5,
      (_) => MockEpisode(),
    );

    when(
      () => _repository.get(
        ids: any(named: 'ids'),
      ),
    ).thenAnswer((_) async => _mockEpisodeList);
  });

  test('Should return a list of episodes', () async {
    final result = await _useCase(
      ids: _ids,
    );

    expect(result, _mockEpisodeList);

    verify(
      () => _repository.get(
        ids: _ids,
      ),
    ).called(1);
  });
}
