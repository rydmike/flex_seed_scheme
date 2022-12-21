import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_data.dart';

/// This is just simple SizedBox in a Card, with a passed in label, background
/// and text label color. Used to show the colors of a theme or scheme
/// color property.
///
/// It also has a tooltip to show the color code, its Material name, if it
/// is a Material 2 color, and it always shows its general/common name, from
/// a list of +1600 color names.
///
/// When you tap the ColorCard the color value is copied to the clipboard
/// in Dart format.
class ColorCard extends StatelessWidget {
  const ColorCard({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
    this.size,
  });

  final String label;
  final Color color;
  final Color textColor;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final bool isPhone = media.size.width < AppData.phoneWidthBreakpoint ||
        media.size.height < AppData.phoneHeightBreakpoint;
    final double fontSize = isPhone ? 10 : 11;
    final Size effectiveSize =
        size ?? (isPhone ? const Size(74, 54) : const Size(86, 58));

    return SizedBox(
      width: effectiveSize.width,
      height: effectiveSize.height,
      child: Tooltip(
        waitDuration: const Duration(milliseconds: 700),
        message: 'Color #${color.hexCode}.'
            '\nTap box to copy RGB value to Clipboard.',
        child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          color: color,
          child: InkWell(
            onTap: () {
              unawaited(copyColorToClipboard(context, color));
            },
            child: Center(
              child: Text(
                label,
                style: TextStyle(color: textColor, fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Copy the color value as a String to the Clipboard in Flutter Dart format.
///
/// Notify with snack bar that it was copied.
Future<void> copyColorToClipboard(BuildContext context, Color color) async {
  final ClipboardData data = ClipboardData(text: '0x${color.hexCode}');
  await Clipboard.setData(data);
  // Show a snack bar with the copy message.
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: <Widget>[
          Card(
            color: color,
            elevation: 0.5,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text('#${color.hexCode}',
                  style: TextStyle(
                      color: ThemeData.estimateBrightnessForColor(color) ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white)),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text('copied color to the clipboard'),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 2000),
    ),
  );
}

/// Extensions on [Color].
extension FlexColorExtensions on Color {
  /// Return uppercase Flutter style hex code string of the color.
  String get hexCode {
    return value.toRadixString(16).toUpperCase().padLeft(8, '0');
  }

  /// Return uppercase RGB hex code string, with # and no alpha value.
  /// This format is often used in APIs and in CSS color values..
  String get hex {
    // ignore: lines_longer_than_80_chars
    return '#${value.toRadixString(16).toUpperCase().padLeft(8, '0').substring(2)}';
  }
}
