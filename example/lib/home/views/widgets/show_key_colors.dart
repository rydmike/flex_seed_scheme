import 'package:flutter/material.dart';

import '../../../core/views/app/color_card.dart';
import '../../../theme/controllers/theme_controller.dart';

/// Draw a number of boxes showing the colors of key theme color properties
/// in the ColorScheme of the inherited ThemeData and its color properties.
class ShowKeyColors extends StatelessWidget {
  const ShowKeyColors({
    super.key,
    required this.controller,
  });

  final ThemeController controller;

  // Return true if the color is light, meaning it needs dark text for contrast.
  static bool _isLight(final Color color) =>
      ThemeData.estimateBrightnessForColor(color) == Brightness.light;

  // On color used when a theme color property does not have a theme onColor.
  static Color _onColor(final Color color, final Color bg) =>
      _isLight(Color.alphaBlend(color, bg)) ? Colors.black : Colors.white;

  @override
  Widget build(BuildContext context) {
    final Color primaryKey = controller.primarySeedColor;
    final Color secondaryKey = controller.secondarySeedColor;
    final Color tertiaryKey = controller.tertiarySeedColor;

    final ThemeData theme = Theme.of(context);
    final Color surface = theme.colorScheme.surface;
    final bool useMaterial3 = theme.useMaterial3;
    const double spacing = 6;

    // Grab the card border from the theme card shape
    ShapeBorder? border = theme.cardTheme.shape;
    // If we had one, copy in a border side to it.
    if (border is RoundedRectangleBorder) {
      border = border.copyWith(
        side: BorderSide(color: theme.dividerColor),
      );
      // If
    } else {
      // If border was null, make one matching Card default, but with border
      // side, if it was not null, we leave it as it was.
      border ??= RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(useMaterial3 ? 12 : 4)),
        side: BorderSide(color: theme.dividerColor),
      );
    }

    // Get effective background color.
    final Color background = theme.cardTheme.color ?? theme.cardColor;

    // Wrap this widget branch in a custom theme where card has a border outline
    // if it did not have one, but retains in ambient themed border radius.
    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: CardTheme.of(context).copyWith(
          elevation: 0,
          shape: border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Seed Colors',
              style: theme.textTheme.titleMedium,
            ),
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: spacing,
            runSpacing: spacing,
            children: <Widget>[
              ColorCard(
                label: 'Primary\nKey',
                color: primaryKey,
                textColor: _onColor(primaryKey, background),
              ),
              ColorCard(
                label: 'Secondary\nKey',
                color: controller.useSecondaryKey ? secondaryKey : surface,
                textColor: controller.useSecondaryKey
                    ? _onColor(secondaryKey, background)
                    : surface,
              ),
              ColorCard(
                label: 'Tertiary\nKey',
                color: controller.useTertiaryKey ? tertiaryKey : surface,
                textColor: controller.useTertiaryKey
                    ? _onColor(tertiaryKey, background)
                    : surface,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
