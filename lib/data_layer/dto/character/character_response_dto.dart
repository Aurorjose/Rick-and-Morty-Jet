import '../../dtos.dart';
import '../../helpers.dart';

/// Data transfer object that represents the characters response from the API.
class CharacterResponseDTO {
  /// The total count of characters.
  int? count;

  /// The total amount of pages.
  int? pages;

  /// The next page.
  int? nextPage;

  ///The requested list of characters
  List<CharacterDTO>? characters;

  ///Creates a [CharacterResponseDTO]
  CharacterResponseDTO({
    this.count,
    this.pages,
    this.nextPage,
    this.characters,
  });

  ///Creates a [CharacterResponseDTO] from a JSON object
  factory CharacterResponseDTO.fromJson(Map<String, dynamic> json) {
    final nextPage = int.tryParse(
      (json['info']?['next'] ?? '').toString().split('?page=').last,
    );

    return CharacterResponseDTO(
      count: JsonParser.parseInt(json['info']?['count']),
      pages: JsonParser.parseInt(json['info']?['pages']),
      nextPage: nextPage,
      characters: CharacterDTO.fromJsonList(
        List<Map<String, dynamic>>.from(json['results']),
      ),
    );
  }
}
