import 'package:flutter/material.dart';

import '../../theme/rm_theme.dart';

/// The button used by the app.
class RMButton extends StatefulWidget {
  /// The callback called on pressed.
  final VoidCallback onPressed;

  /// The title for the button.
  final String title;

  /// Custom text style for the button title.
  final TextStyle? textStyle;

  /// Creates a new [RMButton].
  const RMButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.textStyle,
  }) : super(key: key);

  @override
  State<RMButton> createState() => _RMButtonState();
}

class _RMButtonState extends State<RMButton> {
  /// Whether if the button is pressed or not.
  bool _isPressed = false;
  bool get isPressed => _isPressed;
  set isPressed(bool isPressed) => setState(() => _isPressed = isPressed);

  @override
  Widget build(BuildContext context) => Listener(
        onPointerDown: (_) => isPressed = true,
        onPointerUp: (_) => isPressed = false,
        child: GestureDetector(
          onTapUp: (_) => widget.onPressed(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: isPressed ? RMTheme.secondaryColor : RMTheme.primaryColor,
            ),
            child: Text(
              widget.title,
              style: widget.textStyle ?? RMTheme.buttonFont,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
