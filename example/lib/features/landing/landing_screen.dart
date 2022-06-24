import 'package:flutter/material.dart';

import '../../navigation/rm_navigation_configuration.dart';
import '../../resources/images.dart';
import '../../resources/localizations.dart';
import '../../theme/rm_theme.dart';
import '../../widgets/buttton/rm_button.dart';

/// The landing screen for the ricky and morty app.
class LandingScreen extends StatelessWidget {
  /// Creates a new [LandingScreen].
  const LandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned.fill(
            child: Image.asset(
              Images.rickAndMortyBanner,
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.black.withOpacity(0.65),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(Images.squadmakersLogo),
                    Image.asset(Images.rickAndMortyLogo),
                    const SizedBox(height: 50.0),
                    Text(
                      RMLocalizations.welcomeToRickAndMorty,
                      style: RMTheme.header2.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      RMLocalizations.landingDescription,
                      style: RMTheme.bodyRegularM.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 140.0),
                    RMButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                        context,
                        Screens.characterList,
                      ),
                      title: RMLocalizations.continueText,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
