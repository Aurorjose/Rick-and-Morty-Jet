import '../../models.dart';

/// The abstract repository for the characters.
abstract class CharacterRepositoryInterface {
  Future<CharacterResponse> list({
    int? page,
    String query = '',
    CharacterFilter? filter,
  });

  /// Returns a list of characters related to the passed ids.
  Future<List<Character>> get({
    required List<int> ids,
  });
}
