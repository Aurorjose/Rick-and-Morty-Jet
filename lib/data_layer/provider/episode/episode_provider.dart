import '../../dtos.dart';
import '../../network.dart';

/// Provides episodes data.
class EpisodeProvider {
  final NetworkClient _client;

  /// Creates a new [EpisodeProvider].
  const EpisodeProvider({
    required NetworkClient client,
  }) : _client = client;

  /// Gets the list of episodes related to the passed ids.
  Future<List<EpisodeDTO>> get({
    required List<int> ids,
  }) async {
    final response = await _client.get(
      '${Endpoints.episode}/${ids.join(',')}',
    );

    return response.data is List
        ? EpisodeDTO.fromJsonList(
            List<Map<String, dynamic>>.from(response.data),
          )
        : [
            EpisodeDTO.fromJson(
              Map<String, dynamic>.from(response.data),
            ),
          ];
  }
}
