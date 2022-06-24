import '../../helpers.dart';

class LocationDTO {
  /// The id of the location.
  int? id;

  /// The name of the location.
  String? name;

  /// The type of the location.
  String? type;

  /// The dimension in which the location is located.
  String? dimension;

  /// List of character ids who have been last seen in the location.
  List<int>? residentIds;

  /// Link to the location's own endpoint.
  String? url;

  /// Time at which the location was created in the database.
  DateTime? created;

  /// Creates a new [LocationDTO].
  LocationDTO({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.residentIds,
    this.url,
    this.created,
  });

  /// Creates a [LocationDTO] from a JSON
  factory LocationDTO.fromJson(Map<String, dynamic> json) {
    final residentURLs = List<String>.from(json['residents'] ?? []);

    final residentIds = residentURLs
        .map((url) => int.parse(url.split('character/').last))
        .toList();

    return LocationDTO(
      id: JsonParser.parseInt(json['id']),
      name: json['name'],
      type: json['type'],
      dimension: json['dimension'],
      residentIds: residentIds,
      url: json['url'],
      created: JsonParser.parseStringDate(json['created']),
    );
  }

  /// Creates a list of [LocationDTO] from a list
  static List<LocationDTO> fromJsonList(List<Map<String, dynamic>> json) =>
      json.map(LocationDTO.fromJson).toList(growable: false);
}
