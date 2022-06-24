import '../../abstract_repositories.dart';
import '../../models.dart';

/// Use case that gets a list of characters by their ids.
class GetCharactersByIdsUseCase {
  final CharacterRepositoryInterface _repository;

  /// Creates a new [GetCharactersByIdsUseCase].
  const GetCharactersByIdsUseCase({
    required CharacterRepositoryInterface repository,
  }) : _repository = repository;

  /// Returns a list of characters fetched by their ids.
  Future<List<Character>> call({
    required List<int> ids,
  }) =>
      _repository.get(ids: ids);
}
