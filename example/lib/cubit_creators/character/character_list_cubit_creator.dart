import 'package:rick_and_morty_jose_jet/features/characters.dart';

/// A creator responsible for creating the character list cubit.
class CharacterListCubitCreator {
  final CharacterRepository _repository;

  /// Creates [CharacterListCubitCreator].
  CharacterListCubitCreator({
    required CharacterRepository repository,
  }) : _repository = repository;

  /// Creates a cubit for the character list screen and lists the first page.
  CharacterListCubit create() => CharacterListCubit(
        getCharacterPageUseCase: GetCharacterPageUseCase(
          repository: _repository,
        ),
      )..list();
}
