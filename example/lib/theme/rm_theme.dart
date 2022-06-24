import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The theme used by the app.
class RMTheme {
  /// The primary color.
  static Color get primaryColor => const Color(0xFF12555F);

  /// The secondary color.
  static Color get secondaryColor => const Color(0xFF081F32);

  /// The border color.
  static Color get borderColor => const Color(0xFFB9B9B9);

  /// Font color.
  static Color get fontColor => const Color(0xFF333333);

  /// The font for the buttons.
  static TextStyle get buttonFont => GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 18.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ).fontHeight(22.0);

  /// Header 1.
  static TextStyle get header1 => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 34.0,
          color: fontColor,
          fontWeight: FontWeight.w700,
        ),
      ).fontHeight(41.0);

  /// Header 2.
  static TextStyle get header2 => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 28.0,
          color: fontColor,
          fontWeight: FontWeight.w400,
        ),
      ).fontHeight(34.0);

  /// Header 3.
  static TextStyle get header3 => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 22.0,
          color: fontColor,
          fontWeight: FontWeight.w500,
        ),
      ).fontHeight(27.0);

  /// Body light L.
  static TextStyle get bodyLightL => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 18.0,
          color: fontColor,
          fontWeight: FontWeight.w300,
        ),
      ).fontHeight(22.0);

  /// Body light M.
  static TextStyle get bodyLightM => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 16.0,
          color: fontColor,
          fontWeight: FontWeight.w300,
        ),
      ).fontHeight(20.0);

  /// Body ligth S.
  static TextStyle get bodyLightS => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 14.0,
          color: fontColor,
          fontWeight: FontWeight.w300,
        ),
      ).fontHeight(17.0);

  /// Body light XS.
  static TextStyle get bodyLightXS => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 12.0,
          color: fontColor,
          fontWeight: FontWeight.w300,
        ),
      ).fontHeight(15.0);

  /// Body regular L.
  static TextStyle get bodyRegularL => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 18.0,
          color: fontColor,
          fontWeight: FontWeight.w400,
        ),
      ).fontHeight(30.0);

  /// Body regular M.
  static TextStyle get bodyRegularM => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 16.0,
          color: fontColor,
          fontWeight: FontWeight.w400,
        ),
      ).fontHeight(24.0);

  /// Body regular S.
  static TextStyle get bodyRegularS => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 14.0,
          color: fontColor,
          fontWeight: FontWeight.w400,
        ),
      ).fontHeight(21.0);

  /// Body regular XS.
  static TextStyle get bodyRegularXS => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 12.0,
          color: fontColor,
          fontWeight: FontWeight.w400,
        ),
      ).fontHeight(15.0);

  /// Body medium L.
  static TextStyle get bodyMediumL => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 18.0,
          color: fontColor,
          fontWeight: FontWeight.w500,
        ),
      ).fontHeight(22.0);

  /// Body medium M.
  static TextStyle get bodyMediumM => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 16.0,
          color: fontColor,
          fontWeight: FontWeight.w500,
        ),
      ).fontHeight(20.0);

  /// Body medium S.
  static TextStyle get bodyMediumS => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 14.0,
          color: fontColor,
          fontWeight: FontWeight.w500,
        ),
      ).fontHeight(17.0);

  /// Body medium XS.
  static TextStyle get bodyMediumXS => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 12.0,
          color: fontColor,
          fontWeight: FontWeight.w500,
        ),
      ).fontHeight(15.0);

  /// Body semibold L.
  static TextStyle get bodySemiboldL => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 18.0,
          color: fontColor,
          fontWeight: FontWeight.w600,
        ),
      ).fontHeight(22.0);

  /// Body semibold M.
  static TextStyle get bodySemiboldM => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 16.0,
          color: fontColor,
          fontWeight: FontWeight.w600,
        ),
      ).fontHeight(20.0);

  /// Body semibold S.
  static TextStyle get bodySemiboldS => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 14.0,
          color: fontColor,
          fontWeight: FontWeight.w600,
        ),
      ).fontHeight(17.0);

  /// Body semibold XS.
  static TextStyle get bodySemiboldXS => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 12.0,
          color: fontColor,
          fontWeight: FontWeight.w600,
        ),
      ).fontHeight(15.0);

  /// Body bold L.
  static TextStyle get bodyBoldL => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 18.0,
          color: fontColor,
          fontWeight: FontWeight.w700,
        ),
      ).fontHeight(22.0);

  /// Body bold M.
  static TextStyle get bodyBoldM => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 16.0,
          color: fontColor,
          fontWeight: FontWeight.w700,
        ),
      ).fontHeight(20.0);

  /// Body bold S.
  static TextStyle get bodyBoldS => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 14.0,
          color: fontColor,
          fontWeight: FontWeight.w700,
        ),
      ).fontHeight(17.0);

  /// Body bold XS.
  static TextStyle get bodyBoldXS => GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 12.0,
          color: fontColor,
          fontWeight: FontWeight.w700,
        ),
      ).fontHeight(15.0);
}

/// An extension for easily setting the font height for a [TextStyle]
extension FontHeightExtension on TextStyle {
  /// Returns a copy of the [TextStyle] with the calculated font height.
  ///
  /// The value is calculated by dividing the [TextStyle] fontSize and the
  /// passed height value expressed in logica pixels.
  ///
  /// Example:
  ///   - fontSize: 32
  ///   - passed height: 36
  ///
  ///   return copyWith(height: 36/32);
  ///
  TextStyle fontHeight(double height) =>
      fontSize == null ? this : copyWith(height: height / fontSize!);
}
