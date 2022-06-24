import '../../models.dart';

/// The abstract repository for the episodes.
abstract class EpisodeRepositoryInterface {
  /// Returns a list of episodes related to the passed ids.
  Future<List<Episode>> get({
    required List<int> ids,
  });
}
