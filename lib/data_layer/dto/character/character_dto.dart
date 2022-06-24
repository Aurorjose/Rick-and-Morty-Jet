import '../../dtos.dart';
import '../../helpers.dart';

/// The data transfer object representing a character.
class CharacterDTO {
  /// The id of the character.
  int? id;

  /// The name of the character.
  String? name;

  /// The status of the character.
  CharacterStatusDTO? status;

  /// The species of the character.
  CharacterSpeciesDTO? species;

  /// The type or subspecies of the character.
  String? type;

  /// The gender of the character.
  CharacterGenderDTO? gender;

  /// The character's origin location.
  LocationDTO? origin;

  /// The last known location.
  LocationDTO? location;

  /// Link to the character's image. All images are 300x300px and most are
  /// medium shots or portraits since they are intended to be used as avatars.
  String? imageURL;

  /// List of episodes in which this character appeared.
  List<int>? episodeIds;

  /// Link to the character's own URL endpoint.
  String? url;

  /// Time at which the character was created in the database.
  DateTime? created;

  /// Creates a new [CharacterDTO].
  CharacterDTO({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.imageURL,
    this.episodeIds,
    this.url,
    this.created,
  });

  /// Creates a [CharacterDTO] from a JSON
  factory CharacterDTO.fromJson(Map<String, dynamic> json) {
    final episodeURLs = List<String>.from(json['episode']);

    final episodeIds = episodeURLs
        .map((url) => int.parse(url.split('episode/').last))
        .toList();

    return CharacterDTO(
      id: JsonParser.parseInt(json['id']),
      name: json['name'],
      status: CharacterStatusDTO.fromRaw(json['status']),
      species: CharacterSpeciesDTO.fromRaw(json['species']),
      type: json['type'],
      gender: CharacterGenderDTO.fromRaw(json['gender']),
      origin: LocationDTO.fromJson(json['origin']),
      location: LocationDTO.fromJson(json['location']),
      imageURL: json['image'],
      episodeIds: episodeIds,
      url: json['url'],
      created: JsonParser.parseStringDate(json['created']),
    );
  }

  /// Creates a list of [CharacterDTO] from a list
  static List<CharacterDTO> fromJsonList(List<Map<String, dynamic>> json) =>
      json.map(CharacterDTO.fromJson).toList(growable: false);
}
