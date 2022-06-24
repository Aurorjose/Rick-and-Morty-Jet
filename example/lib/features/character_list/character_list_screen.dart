import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_jose_jet/features/characters.dart';

import '../../resources/images.dart';
import '../../resources/localizations.dart';
import '../../theme/rm_theme.dart';
import '../../widgets/buttton/rm_button.dart';
import '../../widgets/error_view/error_view.dart';
import '../../widgets/loader/loader.dart';
import '../../widgets/search_bar/rm_search_bar.dart';
import 'character_card_view.dart';
import 'character_filter_view.dart';

/// Screen that shows the character list.
class CharacterListScreen extends StatefulWidget {
  /// Creates a new [CharacterListScreen].
  const CharacterListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  DateTime? _lastBackPressTime;

  final _textEditingController = TextEditingController();
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(scrollListener);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _controller.removeListener(scrollListener);
    _controller.dispose();
    super.dispose();
  }

  /// The scroll listener for loading more characters.
  void scrollListener() {
    ScrollPosition position = _controller.position;

    if (position.pixels >= position.maxScrollExtent) {
      final cubit = context.read<CharacterListCubit>();
      if (!cubit.state.busy &&
          cubit.state.errorStatus == CharacterListErrorStatus.none) {
        cubit.list(loadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<CharacterListCubit, CharacterListState>(
        listenWhen: (previous, current) =>
            previous.errorStatus != current.errorStatus &&
            current.errorStatus != CharacterListErrorStatus.none &&
            current.characterResponse?.nextPage != null &&
            !current.busy,
        listener: (context, state) async {
          await Future.delayed(const Duration(milliseconds: 400));
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
          );
        },
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            body: GestureDetector(
              onTap: FocusScope.of(context).unfocus,
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  children: [
                    _buildHeader(),
                    _buildToolBar(),
                    _buildCharacterList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Future<bool> _onWillPop() {
    if (_lastBackPressTime != null) {
      DateTime currentDate = DateTime.now();
      if (currentDate.difference(_lastBackPressTime!) <
          const Duration(seconds: 3)) {
        return Future.value(true);
      }
    }

    _lastBackPressTime = DateTime.now();
    final snackBar = SnackBar(
      content: Text(
        RMLocalizations.pressBackAgainToCloseTheApp,
        style: RMTheme.bodyRegularS.copyWith(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: RMTheme.primaryColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return Future.value(false);
  }

  /// Builds the header view.
  Widget _buildHeader() => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Images.rickAndMortyBanner,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Image.asset(
              Images.rickAndMortyLogo,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65),
              ),
            ),
          ),
          Image.asset(Images.rickAndMortyLogo),
        ],
      );

  /// Builds the toolbar containing the search bar and the side
  /// menu.
  Widget _buildToolBar() => Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 24.0,
        ),
        color: RMTheme.secondaryColor,
        child: Row(
          children: [
            Expanded(
              child: RMSearchBar(
                controller: _textEditingController,
                onChanged: (query) => context
                    .read<CharacterListCubit>()
                    .updateFilterDetails(query: query),
              ),
            ),
            const SizedBox(width: 20.0),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => _openFilterBottomSheet(
                currentFilter: context.read<CharacterListCubit>().state.filter,
              ),
              icon: const Icon(
                Icons.filter_alt_outlined,
                size: 30.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

  /// Shows a bottom sheet for the character filter.
  Future<void> _openFilterBottomSheet({
    required CharacterFilter? currentFilter,
  }) async {
    final filter = await showModalBottomSheet<CharacterFilter>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      builder: (context) => CharacterFilterView(
        currentFilter: currentFilter,
      ),
    );

    if (filter != null && mounted) {
      context.read<CharacterListCubit>().updateFilterDetails(
            filter: filter,
            query: _textEditingController.text,
          );
    }
  }

  /// Builds the character list.
  Widget _buildCharacterList() => Builder(
        builder: (context) {
          final characters = context
                  .watch<CharacterListCubit>()
                  .state
                  .characterResponse
                  ?.characters ??
              const <Character>[];

          final busy = context.watch<CharacterListCubit>().state.busy;

          final notFound =
              context.watch<CharacterListCubit>().state.errorStatus ==
                  CharacterListErrorStatus.notFound;

          final hasError = [
            CharacterListErrorStatus.connectivity,
            CharacterListErrorStatus.generic,
          ].contains(context.watch<CharacterListCubit>().state.errorStatus);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (notFound) _buildNotFoundView(),
              ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 16.0,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: characters.length,
                itemBuilder: (BuildContext context, int index) =>
                    CharacterCardView(
                  character: characters.elementAt(index),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 20.0),
              ),
              if (busy)
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Loader(),
                ),
              if (hasError) _buildErrorView(),
            ],
          );
        },
      );

  /// Builds the not found view.
  Widget _buildNotFoundView() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              RMLocalizations.uhOh,
              style: RMTheme.header1,
            ),
            const SizedBox(height: 10.0),
            Text(
              RMLocalizations.youSeemLostOnYourJorney,
              style: RMTheme.bodyRegularS,
            ),
            const SizedBox(height: 20.0),
            RMButton(
              onPressed: () {
                _textEditingController.clear();
                FocusScope.of(context).unfocus();
                context.read<CharacterListCubit>().updateFilterDetails(
                      filter: const CharacterFilter(),
                      query: '',
                    );
              },
              title: RMLocalizations.clearFilter,
            ),
          ],
        ),
      );

  /// Builds the error view.
  Widget _buildErrorView() {
    final errorStatus = context.watch<CharacterListCubit>().state.errorStatus;
    final shouldLoadMore =
        context.watch<CharacterListCubit>().state.characterResponse?.nextPage !=
            null;

    return ErrorView(
      errorMessage: errorStatus == CharacterListErrorStatus.connectivity
          ? RMLocalizations.connectivityError
          : RMLocalizations.genericError,
      onRetry: () => context.read<CharacterListCubit>().list(
            loadMore: shouldLoadMore,
          ),
    );
  }
}
