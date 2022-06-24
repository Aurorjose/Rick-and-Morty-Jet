import '../../abstract_repositories.dart';
import '../../models.dart';

/// Use case that gets a list of episodes by their ids.
class GetEpisodesByIdsUseCase {
  final EpisodeRepositoryInterface _repository;

  /// Creates a new [GetEpisodesByIdsUseCase].
  const GetEpisodesByIdsUseCase({
    required EpisodeRepositoryInterface repository,
  }) : _repository = repository;

  /// Returns a list of episodes fetched by their ids.
  Future<List<Episode>> call({
    required List<int> ids,
  }) =>
      _repository.get(ids: ids);
}
