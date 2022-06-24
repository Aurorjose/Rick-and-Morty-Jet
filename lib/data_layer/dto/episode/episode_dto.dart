import '../../helpers.dart';

/// The data transfer object representing an episode.
class EpisodeDTO {
  /// The id of the episode.
  int? id;

  /// The name of the episode.
  String? name;

  /// The air date of the episode.
  String? aired;

  /// The code of the episode.
  String? code;

  /// List of characters who have been seen in the episode.
  List<String>? characterURLs;

  /// Link to the episode's own endpoint.
  String? url;

  ///	Time at which the episode was created in the database.
  DateTime? created;

  /// Creates a new [EpisodeDTO].
  EpisodeDTO({
    this.id,
    this.name,
    this.aired,
    this.code,
    this.characterURLs,
    this.url,
    this.created,
  });

  /// Creates a [EpisodeDTO] from a JSON
  factory EpisodeDTO.fromJson(Map<String, dynamic> json) => EpisodeDTO(
        id: JsonParser.parseInt(json['id']),
        name: json['name'],
        aired: json['air_date'],
        code: json['episode'],
        characterURLs: List<String>.from(json['characters']),
        url: json['url'],
        created: JsonParser.parseStringDate(json['created']),
      );

  /// Creates a list of [EpisodeDTO] from a list
  static List<EpisodeDTO> fromJsonList(List<Map<String, dynamic>> json) =>
      json.map(EpisodeDTO.fromJson).toList(growable: false);
}
