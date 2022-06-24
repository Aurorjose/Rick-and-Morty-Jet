import 'dart:collection';

import 'package:equatable/equatable.dart';

/// The model for the episodes.
class Episode extends Equatable {
  /// The id.
  final int id;

  /// The name.
  final String name;

  /// The air date of the episode.
  final String aired;

  /// The code.
  final String code;

  /// List of characters who have been seen in the episode.
  final UnmodifiableListView<String> characterURLs;

  /// Episode's own endpoint.
  final String url;

  /// Time at which the episode was created in the database.
  final DateTime? created;

  /// Creates a new [Episode].
  Episode({
    required this.id,
    required this.name,
    required this.aired,
    required this.code,
    Iterable<String>? characterURLs,
    required this.url,
    this.created,
  }) : characterURLs = UnmodifiableListView(
          characterURLs ?? <String>[],
        );

  @override
  List<Object?> get props => [
        id,
        name,
        aired,
        code,
        characterURLs,
        url,
        created,
      ];
}
