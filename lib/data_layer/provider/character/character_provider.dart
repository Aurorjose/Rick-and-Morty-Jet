import '../../dtos.dart';
import '../../network.dart';

/// Provides characters data.
class CharacterProvider {
  final NetworkClient _client;

  /// Creates a new [CharacterProvider].
  const CharacterProvider({
    required NetworkClient client,
  }) : _client = client;

  /// Lists a list of characters.
  ///
  /// The [page] parameter is used for pagination purposes.
  Future<CharacterResponseDTO> list({
    int? page,
    String query = '',
    CharacterFilterDTO? filter,
  }) async {
    final response = await _client.get(
      Endpoints.character,
      queryParameters: {
        if (page != null) 'page': page,
        if (query.isNotEmpty) 'name': query,
        if (filter?.species != null) 'species': filter!.species!.value,
        if (filter?.status != null) 'status': filter!.status!.value,
      },
    );

    return CharacterResponseDTO.fromJson(response.data);
  }

  /// Gets the list of characters related to the passed ids.
  Future<List<CharacterDTO>> get({
    required List<int> ids,
  }) async {
    final response = await _client.get(
      '${Endpoints.character}/${ids.join(',')}',
    );

    return response.data is List
        ? CharacterDTO.fromJsonList(
            List<Map<String, dynamic>>.from(response.data),
          )
        : [
            CharacterDTO.fromJson(
              Map<String, dynamic>.from(response.data),
            ),
          ];
  }
}
