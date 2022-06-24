import 'package:flutter/material.dart';

import '../../resources/localizations.dart';
import '../../theme/rm_theme.dart';
import '../buttton/rm_button.dart';

/// The error view for the app.
class ErrorView extends StatelessWidget {
  /// The error message to show.
  final String errorMessage;

  /// The retry callback.
  final VoidCallback onRetry;

  /// Creates a new [ErrorView].
  const ErrorView({
    Key? key,
    required this.errorMessage,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
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
              errorMessage,
              style: RMTheme.bodyRegularS,
            ),
            const SizedBox(height: 20.0),
            RMButton(
              onPressed: onRetry,
              title: RMLocalizations.retry,
            ),
          ],
        ),
      );
}
