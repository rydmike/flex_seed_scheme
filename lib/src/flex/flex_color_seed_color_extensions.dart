import 'dart:ui';

/// Library private extensions on [Color].
extension FlexColorSeedColorExtensions on Color {
  /// A 32 bit value representing this color.
  ///
  /// This feature brings back the Color.value API in a way that is not and
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
