import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Extensions on [Color] to brighten, lighten, darken and blend colors and
/// can get a shade for gradients.
///
/// These extensions are rewrites of TinyColor's functions
/// https://pub.dev/packages/tinycolor. The TinyColor algorithms have also
/// been modified to use Flutter's HSLColor class instead of the custom one in
/// the TinyColor lib. The functions from TinyColor re-implemented as Color
/// extensions here are [brighten], [lighten] and [darken]. They are used
/// for color calculations in FlexColorScheme, but also exposed for reuse.
extension FlexColorExtensions on Color {
  /// Brightens the color with the given integer percentage amount.
  /// Defaults to 10%.
  Color brighten([final int amount = 10]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.white;
    final Color color = Color.fromARGB(
      alpha8bit,
      math.max(0, math.min(255, red8bit - (255 * -(amount / 100)).round())),
      math.max(0, math.min(255, green8bit - (255 * -(amount / 100)).round())),
      math.max(0, math.min(255, blue8bit - (255 * -(amount / 100)).round())),
    );
    return color;
  }

  /// Lightens the color with the given integer percentage amount.
  /// Defaults to 10%.
  Color lighten([final int amount = 10]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.white;
    // HSLColor returns saturation 1 for black, we want 0 instead to be able
    // lighten black color up along the grey scale from black.
    final HSLColor hsl = this == const Color(0xFF000000)
        ? HSLColor.fromColor(this).withSaturation(0)
        : HSLColor.fromColor(this);
    return hsl
        .withLightness(math.min(1, math.max(0, hsl.lightness + amount / 100)))
        .toColor();
  }

  /// Darkens the color with the given integer percentage amount.
  /// Defaults to 10%.
  Color darken([final int amount = 10]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.black;
    final HSLColor hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness(math.min(1, math.max(0, hsl.lightness - amount / 100)))
        .toColor();
  }

  /// Return uppercase Flutter style hex code string of the color.
  String get hexCode {
    return value32bit.toRadixString(16).toUpperCase().padLeft(8, '0');
  }

  /// Return uppercase RGB hex code string, with # and no alpha value.
  /// This format is often used in APIs and in CSS color values..
  String get hex {
    // ignore: lines_longer_than_80_chars
    return '#${value32bit.toRadixString(16).toUpperCase().padLeft(8, '0').substring(2)}';
  }

  /// A 32 bit value representing this color.
  ///
  /// This feature brings back the Color.value32bit API in a way that is not and
  /// will not be deprecated.
  ///
  /// The bits are assigned as follows:
  ///
  /// * Bits 24-31 are the alpha value.
  /// * Bits 16-23 are the red value.
  /// * Bits 8-15 are the green value.
  /// * Bits 0-7 are the blue value.
  int get value32bit {
    return _floatToInt8(a) << 24 |
        _floatToInt8(r) << 16 |
        _floatToInt8(g) << 8 |
        _floatToInt8(b) << 0;
  }

  /// The alpha channel of this color in an 8 bit value.
  ///
  /// A value of 0 means this color is fully transparent. A value of 255 means
  /// this color is fully opaque.
  ///
  /// This feature brings back the Color.alpha API in a way that is not and
  /// will not be deprecated.
  int get alpha8bit => (0xff000000 & value32bit) >> 24;

  /// The red channel of this color in an 8 bit value.
  ///
  /// This feature brings back the Color.red API in a way that is not and
  /// will not be deprecated.
  int get red8bit => (0x00ff0000 & value32bit) >> 16;

  /// The green channel of this color in an 8 bit value.
  ///
  /// This feature brings back the Color.green API in a way that is not and
  /// will not be deprecated.
  int get green8bit => (0x0000ff00 & value32bit) >> 8;

  /// The blue channel of this color in an 8 bit value.
  ///
  /// This feature brings back the Color.blue API in a way that is not and
  /// will not be deprecated.
  int get blue8bit => (0x000000ff & value32bit) >> 0;

  // Convert float to 8 bit integer.
  int _floatToInt8(double x) {
    return (x * 255.0).round() & 0xff;
  }
}
