import 'dart:collection';

import 'package:equatable/equatable.dart';

/// The location model.
class Location extends Equatable {
  /// The id.
  final int id;

  /// The name.
  final String name;

  /// The type.
  final String type;

  /// The dimension in which the location is located.
  final String dimension;

  /// List of character ids who have been last seen in the location.
  final UnmodifiableListView<int> residentIds;

  /// The location's own endpoint.
  final String url;

  /// Time at which the location was created in the database.
  final DateTime? created;

  /// Creates a new [Location].
  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    Iterable<int>? residentIds,
    required this.url,
    this.created,
  }) : residentIds = UnmodifiableListView(
          residentIds ?? <int>[],
        );

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        dimension,
        residentIds,
        url,
        created,
      ];
}
