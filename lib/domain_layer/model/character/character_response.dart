import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../../models.dart';

/// The characters response model.
class CharacterResponse extends Equatable {
  /// The total count of characters.
  final int? count;

  /// The total amount of pages.
  final int? pages;

  /// The next page.
  final int? nextPage;

  /// The requested list of characters
  final UnmodifiableListView<Character> characters;

  ///Creates a [CharacterResponse].
  CharacterResponse({
    this.count,
    this.pages,
    this.nextPage,
    Iterable<Character> characters = const <Character>[],
  }) : characters = UnmodifiableListView(
          characters,
        );

  /// Creates a copy of this character response.
  CharacterResponse copyWith({
    int? count,
    int? pages,
    int? nextPage,
    Iterable<Character>? characters,
  }) =>
      CharacterResponse(
        count: count ?? this.count,
        pages: pages ?? this.pages,
        nextPage: nextPage ?? this.pages,
        characters: characters ?? this.characters,
      );

  @override
  List<Object?> get props => [
        count,
        pages,
        nextPage,
        characters,
      ];
}
