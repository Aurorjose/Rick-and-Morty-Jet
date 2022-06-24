import 'package:flutter/material.dart';
import 'package:rick_and_morty_jose_jet/features/characters.dart';

import '../../extensions/character/character_ui_extension.dart';
import '../../resources/localizations.dart';
import '../../theme/rm_theme.dart';
import '../../widgets/buttton/rm_button.dart';

/// The character filter view.
class CharacterFilterView extends StatefulWidget {
  /// The current character filter.
  final CharacterFilter? currentFilter;

  /// Creates a new [CharacterFilterView].
  const CharacterFilterView({
    Key? key,
    this.currentFilter,
  }) : super(key: key);

  @override
  State<CharacterFilterView> createState() => _CharacterFilterViewState();
}

class _CharacterFilterViewState extends State<CharacterFilterView> {
  /// Copy of the passed filter.
  late CharacterFilter _filter =
      widget.currentFilter?.copyWith() ?? const CharacterFilter();
  CharacterFilter get filter => _filter;
  set filter(CharacterFilter filter) => setState(() => _filter = filter);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    RMLocalizations.characterFilter,
                    style: RMTheme.header3,
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    size: 30.0,
                    color: RMTheme.fontColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              RMLocalizations.species,
              style: RMTheme.bodyLightS,
            ),
            const SizedBox(height: 5.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: CharacterSpecies.values
                  .map((species) => _buildFilterEntry(
                        title: species.localize,
                        selected: filter.species == species,
                        onPressed: () =>
                            filter = filter.copyWith(species: species),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 15.0),
            Text(
              RMLocalizations.status,
              style: RMTheme.bodyLightS,
            ),
            const SizedBox(height: 5.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: CharacterStatus.values
                  .map((status) => _buildFilterEntry(
                        title: status.localize,
                        selected: filter.status == status,
                        onPressed: () =>
                            filter = filter.copyWith(status: status),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 35.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RMButton(
                    onPressed: () => Navigator.pop(
                      context,
                      filter,
                    ),
                    title: RMLocalizations.save,
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: RMButton(
                    onPressed: () => Navigator.pop(
                      context,
                      const CharacterFilter(),
                    ),
                    title: RMLocalizations.clearFilter,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  /// Builds a filter entry item.
  Widget _buildFilterEntry({
    required String title,
    required bool selected,
    required VoidCallback onPressed,
  }) =>
      GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: selected ? RMTheme.secondaryColor : RMTheme.borderColor,
            ),
            color: selected ? RMTheme.primaryColor : Colors.transparent,
          ),
          child: Text(
            title,
            style: RMTheme.bodyMediumL.copyWith(
              color: selected ? Colors.white : RMTheme.fontColor,
            ),
          ),
        ),
      );
}
