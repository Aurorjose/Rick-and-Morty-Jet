import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_jose_jet/features/characters.dart';

import '../../extensions/character/character_ui_extension.dart';
import '../../navigation/rm_navigation_configuration.dart';
import '../../resources/localizations.dart';
import '../../theme/rm_theme.dart';

/// The card view for a character.
class CharacterCardView extends StatelessWidget {
  /// The character.
  final Character character;

  /// Whethere if the character should replace the current route or not.
  final bool shouldPushReplacement;

  /// Creates a new [CharacterCardView].
  const CharacterCardView({
    Key? key,
    required this.character,
    this.shouldPushReplacement = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => (shouldPushReplacement
            ? Navigator.pushReplacementNamed
            : Navigator.pushNamed)(
          context,
          Screens.characterDetails,
          arguments: character,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: RMTheme.borderColor),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                    height: constraints.maxWidth,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          character.imageURL,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: _buildCharacterDetails(),
              )
            ],
          ),
        ),
      );

  /// Builds the character details.
  Widget _buildCharacterDetails() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${character.status.localize} - ${character.species.localize}',
              style: RMTheme.bodyLightXS,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              character.name,
              style: RMTheme.bodyRegularS,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10.0),
            Text(
              RMLocalizations.lastKnownLocation,
              style: RMTheme.bodyLightXS,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              character.location?.name ?? '-',
              style: RMTheme.bodyRegularS,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10.0),
            Text(
              RMLocalizations.firstSeenIn,
              style: RMTheme.bodyLightXS,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              character.origin?.name ?? '-',
              style: RMTheme.bodyRegularS,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}
