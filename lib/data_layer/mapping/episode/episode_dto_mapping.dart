import '../../../domain_layer/models.dart';
import '../../dtos.dart';

/// Mapping extensions on the [EpisodeDTO].
extension EpisodeDTOMapping on EpisodeDTO {
  /// Maps a [EpisodeDTO] into a [Episode].
  Episode toEpisode() => Episode(
        id: id ?? 0,
        name: name ?? '',
        aired: aired ?? '',
        code: code ?? '',
        characterURLs: characterURLs,
        url: url ?? '',
        created: created,
      );
}
