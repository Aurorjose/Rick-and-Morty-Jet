import '../../../domain_layer/abstract_repositories.dart';
import '../../../domain_layer/models.dart';
import '../../mappings.dart';
import '../../providers.dart';

/// The episode repository.
class EpisodeRepository implements EpisodeRepositoryInterface {
  final EpisodeProvider _provider;

  /// Creates a new [EpisodeRepository].
  const EpisodeRepository({
    required EpisodeProvider provider,
  }) : _provider = provider;

  /// Returns a list of episodes related to the passed ids.
  @override
  Future<List<Episode>> get({
    required List<int> ids,
  }) async {
    final episodeDTOList = await _provider.get(
      ids: ids,
    );

    return episodeDTOList.map((e) => e.toEpisode()).toList(growable: false);
  }
}
