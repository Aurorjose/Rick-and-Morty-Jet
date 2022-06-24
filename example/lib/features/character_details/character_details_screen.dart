import 'package:collection/collection.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_jose_jet/features/characters.dart';
import 'package:rick_and_morty_jose_jet/features/episodes.dart';

import '../../extensions/character/character_ui_extension.dart';
import '../../resources/images.dart';
import '../../resources/localizations.dart';
import '../../theme/rm_theme.dart';
import '../../widgets/error_view/error_view.dart';
import '../../widgets/loader/loader.dart';
import '../character_list/character_card_view.dart';

/// The character details screen.
class CharacterDetailsScreen extends StatefulWidget {
  /// Creates a new [CharacterDetailsScreen].
  const CharacterDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  /// Whether if all the episodes should be shown or only the first 4.
  var _showAllEpisodes = false;
  bool get showAllEpisodes => _showAllEpisodes;
  set showAllEpisodes(bool show) => setState(() => _showAllEpisodes = show);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildInformationView(),
                    const SizedBox(height: 70.0),
                    _buildEpisodesView(),
                    const SizedBox(height: 70.0),
                    _buildCharactersView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  /// Builds the character details header.
  Widget _buildHeader() {
    final containerWidth = MediaQuery.of(context).size.width;
    final containerHeight = containerWidth / 2;

    final character = context.select<CharacterDetailsCubit, Character>(
        (cubit) => cubit.state.character);

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: containerHeight,
              width: containerWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Images.characterDetailsBanner,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: containerHeight,
              width: containerWidth,
              color: RMTheme.secondaryColor,
            )
          ],
        ),
        Positioned(
          top: 40.0,
          left: 20.0,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              size: 30.0,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: containerWidth / 3,
                width: containerWidth / 3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      character.imageURL,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Text(
                character.status.localize.toUpperCase(),
                style: RMTheme.bodyLightS.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                character.name,
                style: RMTheme.bodyMediumL.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                character.species.localize.toUpperCase(),
                style: RMTheme.bodyLightS.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the information view.
  Widget _buildInformationView() {
    final character = context.select<CharacterDetailsCubit, Character>(
        (cubit) => cubit.state.character);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          RMLocalizations.information,
          style: RMTheme.bodyMediumL.copyWith(color: RMTheme.borderColor),
        ),
        const SizedBox(height: 20.0),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / 2 - 10;

            return SizedBox(
              width: double.maxFinite,
              child: Wrap(
                spacing: 20.0,
                runSpacing: 10.0,
                children: [
                  _buildInformationItem(
                    title: RMLocalizations.gender,
                    value: character.gender.localize,
                    itemWidth: itemWidth,
                  ),
                  _buildInformationItem(
                    title: RMLocalizations.origin,
                    value: character.origin?.name ?? '-',
                    itemWidth: itemWidth,
                  ),
                  _buildInformationItem(
                    title: RMLocalizations.type,
                    value: (character.type ?? '').isEmpty
                        ? 'Unknown'
                        : character.type!,
                    itemWidth: itemWidth,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  /// Builds an information item.
  Widget _buildInformationItem({
    required String title,
    required String value,
    required double itemWidth,
  }) =>
      Container(
        width: itemWidth,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: RMTheme.borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_rounded,
                  color: RMTheme.borderColor,
                  size: 17.0,
                ),
                const SizedBox(width: 5.0),
                Text(
                  title,
                  style: RMTheme.bodyLightXS,
                ),
              ],
            ),
            Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: RMTheme.bodySemiboldM,
            ),
          ],
        ),
      );

  /// Builds the episodes view.
  Widget _buildEpisodesView() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            RMLocalizations.episodes,
            style: RMTheme.bodyMediumL.copyWith(color: RMTheme.borderColor),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.maxFinite,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / 2 - 10;

                final state = context.watch<CharacterDetailsCubit>().state;

                final episodes = state.episodes;
                final busy = state.actions.contains(
                  CharacterDetailsAction.episodes,
                );
                final error = state.errors
                    .firstWhereOrNull(
                      (e) => e.action == CharacterDetailsAction.episodes,
                    )
                    ?.error;

                return busy
                    ? const Center(
                        child: Loader(),
                      )
                    : error != null
                        ? ErrorView(
                            errorMessage: error ==
                                    CharacterDetailsErrorStatus.connectivity
                                ? RMLocalizations.connectivityError
                                : RMLocalizations.genericError,
                            onRetry: () => context
                                .read<CharacterDetailsCubit>()
                                .getEpisodes(),
                          )
                        : episodes.isEmpty
                            ? Text(
                                RMLocalizations
                                    .notEpisodesFoundForThisCharacter,
                                style: RMTheme.bodyRegularS,
                                textAlign: TextAlign.center,
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 20.0,
                                    runSpacing: 10.0,
                                    children: (showAllEpisodes
                                            ? episodes
                                            : episodes.take(4))
                                        .map((episode) => _buildEpisodeItem(
                                              episode: episode,
                                              itemWidth: itemWidth,
                                            ))
                                        .toList(),
                                  ),
                                  if (episodes.length > 4)
                                    GestureDetector(
                                      onTap: () =>
                                          showAllEpisodes = !showAllEpisodes,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            showAllEpisodes
                                                ? RMLocalizations.showLess
                                                : RMLocalizations.showMore,
                                            style:
                                                RMTheme.bodySemiboldM.copyWith(
                                              color: RMTheme.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
              },
            ),
          ),
        ],
      );

  /// Builds an episode item.
  Widget _buildEpisodeItem({
    required Episode episode,
    required double itemWidth,
  }) =>
      Container(
        width: itemWidth,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: RMTheme.borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              episode.name,
              overflow: TextOverflow.ellipsis,
              style: RMTheme.bodyLightXS,
            ),
            Text(
              episode.code,
              style: RMTheme.bodySemiboldM,
            ),
            const SizedBox(height: 10.0),
            Text(
              episode.aired.toUpperCase(),
              style: RMTheme.bodyLightXS,
            ),
          ],
        ),
      );

  /// Builds the related characters view.
  Widget _buildCharactersView() => Builder(
        builder: (context) {
          final state = context.watch<CharacterDetailsCubit>().state;

          final relatedCharacters = state.relatedCharacters;
          final busy = state.actions.contains(
            CharacterDetailsAction.relatedCharacters,
          );
          final error = state.errors
              .firstWhereOrNull(
                (e) => e.action == CharacterDetailsAction.relatedCharacters,
              )
              ?.error;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                RMLocalizations.relatedCharacters,
                style: RMTheme.bodyMediumL.copyWith(color: RMTheme.borderColor),
              ),
              const SizedBox(height: 20.0),
              busy
                  ? const Center(
                      child: Loader(),
                    )
                  : error != null
                      ? SizedBox(
                          width: double.maxFinite,
                          child: ErrorView(
                            errorMessage: error ==
                                    CharacterDetailsErrorStatus.connectivity
                                ? RMLocalizations.connectivityError
                                : RMLocalizations.genericError,
                            onRetry: () => context
                                .read<CharacterDetailsCubit>()
                                .getRelatedCharacters(),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: relatedCharacters.length,
                          itemBuilder: (BuildContext context, int index) =>
                              CharacterCardView(
                            shouldPushReplacement: true,
                            character: relatedCharacters.elementAt(index),
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 20.0),
                        ),
            ],
          );
        },
      );
}
