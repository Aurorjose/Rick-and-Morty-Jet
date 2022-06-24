import 'package:rick_and_morty_jose_jet/features/characters.dart';
import 'package:rick_and_morty_jose_jet/features/episodes.dart';

/// A creator responsible for creating the character details cubit.
class CharacterDetailsCubitCreator {
  final CharacterRepository _characterRepository;
  final EpisodeRepository _episodeRepository;

  /// Creates [CharacterDetailsCubitCreator].
  CharacterDetailsCubitCreator({
    required CharacterRepository characterRepository,
    required EpisodeRepository episodeRepository,
  })  : _characterRepository = characterRepository,
        _episodeRepository = episodeRepository;

  /// Creates a cubit for the character details screen and gets the episodes
  /// and related characters
  CharacterDetailsCubit create({
    required Character character,
  }) =>
      CharacterDetailsCubit(
        character: character,
        getEpisodedByIdsUseCase: GetEpisodesByIdsUseCase(
          repository: _episodeRepository,
        ),
        getCharactersByIdsUseCase: GetCharactersByIdsUseCase(
          repository: _characterRepository,
        ),
      )
        ..getEpisodes()
        ..getRelatedCharacters();
}
