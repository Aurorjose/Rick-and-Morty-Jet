import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_jose_jet/features/characters.dart';

import '../cubit_creators/cubir_creators.dart';
import '../features/character_details/character_details_screen.dart';
import '../features/character_list/character_list_screen.dart';
import '../features/landing/landing_screen.dart';

/// A configuration class that defines initial route
/// and defines how routes are generated.
class RMNavigationConfiguration {
  String get initialRoute => Screens.landing;

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Keep this alphabetized

      case Screens.characterDetails:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CharacterDetailsCubit>(
            create: (context) => context
                .read<CharacterDetailsCubitCreator>()
                .create(character: (settings.arguments as Character)),
            child: const CharacterDetailsScreen(),
          ),
          settings: settings,
        );

      case Screens.characterList:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CharacterListCubit>(
            create: (context) =>
                context.read<CharacterListCubitCreator>().create(),
            child: const CharacterListScreen(),
          ),
          settings: settings,
        );

      case Screens.landing:
        return MaterialPageRoute(
          builder: (context) => const LandingScreen(),
          settings: settings,
        );

      default:
        throw UnsupportedError('Route ${settings.name} is not supported');
    }
  }
}

/// A class that keeps track of all available route names.
abstract class Screens {
  // Keep this alphabetized

  /// The character details screen.
  static const String characterDetails = 'characterDetails';

  /// The character list screen.
  static const String characterList = 'characterList';

  /// The landing screen.
  static const String landing = 'landing';
}
