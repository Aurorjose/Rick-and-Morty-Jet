import '../../../domain_layer/abstract_repositories.dart';
import '../../../domain_layer/models.dart';
import '../../mappings.dart';
import '../../providers.dart';

/// The character repository.
class CharacterRepository implements CharacterRepositoryInterface {
  final CharacterProvider _provider;

  /// Creates a new [CharacterRepository].
  const CharacterRepository({
    required CharacterProvider provider,
  }) : _provider = provider;

  @override
  Future<CharacterResponse> list({
    int? page,
    String query = '',
    CharacterFilter? filter,
  }) async {
    final characterResponseDTO = await _provider.list(
      page: page,
      query: query,
      filter: filter?.toDTO(),
    );

    return characterResponseDTO.toCharacterResponse();
  }

  /// Returns a list of characters related to the passed ids.
  @override
  Future<List<Character>> get({
    required List<int> ids,
  }) async {
    final characterDTOList = await _provider.get(
      ids: ids,
    );

    return characterDTOList.map((e) => e.toCharacter()).toList(growable: false);
  }
}
