import 'package:flutter/material.dart';

import '../../theme/rm_theme.dart';

/// The loader view used by the app.
class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
        backgroundColor: RMTheme.primaryColor,
      );
}
