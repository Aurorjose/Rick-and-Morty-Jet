import 'dart:async';

import 'package:flutter/material.dart';

import '../../resources/localizations.dart';
import '../../theme/rm_theme.dart';

/// The search bar used by the app.
class RMSearchBar extends StatefulWidget {
  /// The controller.
  final TextEditingController? controller;

  /// The callback called when the search bar changes.
  final ValueChanged<String> onChanged;

  /// Creates a new [RMSearchBar].
  const RMSearchBar({
    Key? key,
    this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RMSearchBar> createState() => _RMSearchBarState();
}

class _RMSearchBarState extends State<RMSearchBar> {
  Timer? _debounce;
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  /// Debounce on changed.
  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onChanged(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = RMTheme.bodyRegularM
        .copyWith(
          color: Colors.white,
        )
        .fontHeight(19.5);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 13.0,
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search_outlined,
            size: 24.0,
            color: Colors.white,
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              style: textStyle,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: RMLocalizations.searchCharacter,
                hintStyle: textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
