import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_jose_jet/data_layer/network.dart';
import 'package:rick_and_morty_jose_jet/features/characters.dart';
import 'package:rick_and_morty_jose_jet/features/episodes.dart';

import 'cubit_creators/cubir_creators.dart';
import 'navigation/rm_navigation_configuration.dart';

void main() => runApp(RickAndMortyApp());

class RickAndMortyApp extends StatelessWidget {
  late final RMNavigationConfiguration _navigationConfiguration;

  late final NetworkClient _networkClient;

  late final CharacterProvider _characterProvider;
  late final CharacterRepository _characterRepository;

  late final EpisodeProvider _episodeProvider;
  late final EpisodeRepository _episodeRepository;

  RickAndMortyApp({
    Key? key,
  }) : super(key: key) {
    _navigationConfiguration = RMNavigationConfiguration();

    _networkClient = NetworkClient(
      baseURL: 'https://rickandmortyapi.com/api',
    );

    _characterProvider = CharacterProvider(client: _networkClient);
    _characterRepository = CharacterRepository(provider: _characterProvider);

    _episodeProvider = EpisodeProvider(client: _networkClient);
    _episodeRepository = EpisodeRepository(provider: _episodeProvider);
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<CharacterListCubitCreator>(
            create: (context) => CharacterListCubitCreator(
              repository: _characterRepository,
            ),
          ),
          Provider<CharacterDetailsCubitCreator>(
            create: (context) => CharacterDetailsCubitCreator(
              characterRepository: _characterRepository,
              episodeRepository: _episodeRepository,
            ),
          ),
        ],
        child: MaterialApp(
          initialRoute: _navigationConfiguration.initialRoute,
          onGenerateRoute: _navigationConfiguration.onGenerateRoute,
        ),
      );
}
