import '../../abstract_repositories.dart';
import '../../models.dart';

/// Use case for getting a character page.
class GetCharacterPageUseCase {
  final CharacterRepositoryInterface _repository;

  /// Creates a new [GetCharacterPageUseCase].
  const GetCharacterPageUseCase({
    required CharacterRepositoryInterface repository,
  }) : _repository = repository;

  /// Returns a character response containing the character belonging to the
  /// passed page.
  Future<CharacterResponse> call({
    required int page,
    String query = '',
    CharacterFilter? filter,
  }) =>
      _repository.list(
        page: page,
        query: query,
        filter: filter,
      );
}
