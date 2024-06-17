import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/flex_color_extension.dart';
import '../app/copy_color_to_clipboard.dart';

const Size _colorChipSize = Size(160, 50);
const Size _onChipSize = Size(160, 36);
const Size _equalFourChipSize = Size(160, 43);
const Size _equalThreeChipSize = Size(160, 57.333);

/// A view that shows all the colors in a [ColorScheme].
///
/// It also allows copying the color values to the clipboard by tapping the
/// scheme color.
class ColorSchemeView extends StatelessWidget {
  const ColorSchemeView({super.key, this.scheme, this.showColorValue = false});

  final ColorScheme? scheme;
  final bool showColorValue;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = scheme ?? theme.colorScheme;
    final bool useMaterial3 = theme.useMaterial3;
    const double spacing = 6;

    // Grab the card border from the theme card shape
    ShapeBorder? border = theme.cardTheme.shape;
    // If we had one, copy in a border side to it.
    if (border is RoundedRectangleBorder) {
      border = border.copyWith(
        side: BorderSide(color: colorScheme.outlineVariant),
      );
      // If
    } else {
      // If border was null, make one matching Card default, but with border
      // side, if it was not null, we leave it as it was.
      border ??= RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(useMaterial3 ? 12 : 4)),
        side: BorderSide(color: colorScheme.outlineVariant),
      );
    }

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
              'ColorScheme Colors',
              style: theme.textTheme.titleMedium,
            ),
          ),
          Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: <Widget>[
              ColorGroup(children: <Widget>[
                ColorChip(
                  label: 'primary',
                  color: colorScheme.primary,
                  onColor: colorScheme.onPrimary,
                  size: _colorChipSize,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'onPrimary',
                  color: colorScheme.onPrimary,
                  onColor: colorScheme.primary,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'primaryContainer',
                  color: colorScheme.primaryContainer,
                  onColor: colorScheme.onPrimaryContainer,
                  size: _colorChipSize,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'onPrimaryContainer',
                  color: colorScheme.onPrimaryContainer,
                  onColor: colorScheme.primaryContainer,
                  showValue: showColorValue,
                ),
              ]),
              ColorGroup(children: <Widget>[
                ColorChip(
                  label: 'primaryFixed',
                  color: colorScheme.primaryFixed,
                  onColor: colorScheme.onPrimaryFixed,
                  size: _colorChipSize,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'onPrimaryFixed',
                  color: colorScheme.onPrimaryFixed,
                  onColor: colorScheme.primaryFixed,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'primaryFixedDim',
                  color: colorScheme.primaryFixedDim,
                  onColor: colorScheme.onPrimaryFixedVariant,
                  size: _colorChipSize,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'onPrimaryFixedVariant',
                  color: colorScheme.onPrimaryFixedVariant,
                  onColor: colorScheme.primaryFixedDim,
                  showValue: showColorValue,
                ),
              ]),
              ColorGroup(children: <Widget>[
                ColorChip(
                  label: 'secondary',
                  color: colorScheme.secondary,
                  onColor: colorScheme.onSecondary,
                  size: _colorChipSize,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'onSecondary',
                  color: colorScheme.onSecondary,
                  onColor: colorScheme.secondary,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'secondaryContainer',
                  color: colorScheme.secondaryContainer,
                  onColor: colorScheme.onSecondaryContainer,
                  size: _colorChipSize,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'onSecondaryContainer',
                  color: colorScheme.onSecondaryContainer,
                  onColor: colorScheme.secondaryContainer,
                  showValue: showColorValue,
                ),
              ]),
              ColorGroup(children: <Widget>[
                ColorChip(
                  label: 'secondaryFixed',
                  color: colorScheme.secondaryFixed,
                  onColor: colorScheme.onSecondaryFixed,
                  size: _colorChipSize,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'onSecondaryFixed',
                  color: colorScheme.onSecondaryFixed,
                  onColor: colorScheme.secondaryFixed,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'secondaryFixedDim',
                  color: colorScheme.secondaryFixedDim,
                  onColor: colorScheme.onSecondaryFixedVariant,
                  size: _colorChipSize,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'onSecondaryFixedVariant',
                  color: colorScheme.onSecondaryFixedVariant,
                  onColor: colorScheme.secondaryFixedDim,
                  showValue: showColorValue,
                ),
              ]),
              ColorGroup(
                children: <Widget>[
                  ColorChip(
                    label: 'tertiary',
                    color: colorScheme.tertiary,
                    onColor: colorScheme.onTertiary,
                    size: _colorChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'onTertiary',
                    color: colorScheme.onTertiary,
                    onColor: colorScheme.tertiary,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'tertiaryContainer',
                    color: colorScheme.tertiaryContainer,
                    onColor: colorScheme.onTertiaryContainer,
                    size: _colorChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'onTertiaryContainer',
                    color: colorScheme.onTertiaryContainer,
                    onColor: colorScheme.tertiaryContainer,
                    showValue: showColorValue,
                  ),
                ],
              ),
              ColorGroup(children: <Widget>[
                ColorChip(
                  label: 'tertiaryFixed',
                  color: colorScheme.tertiaryFixed,
                  onColor: colorScheme.onTertiaryFixed,
                  size: _colorChipSize,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'onTertiaryFixed',
                  color: colorScheme.onTertiaryFixed,
                  onColor: colorScheme.tertiaryFixed,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'tertiaryFixedDim',
                  color: colorScheme.tertiaryFixedDim,
                  onColor: colorScheme.onTertiaryFixedVariant,
                  size: _colorChipSize,
                  showValue: showColorValue,
                ),
                ColorChip(
                  label: 'onTertiaryFixedVariant',
                  color: colorScheme.onTertiaryFixedVariant,
                  onColor: colorScheme.tertiaryFixedDim,
                  showValue: showColorValue,
                ),
              ]),
              ColorGroup(
                children: <Widget>[
                  ColorChip(
                    label: 'error',
                    color: colorScheme.error,
                    onColor: colorScheme.onError,
                    size: _colorChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'onError',
                    color: colorScheme.onError,
                    onColor: colorScheme.error,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'errorContainer',
                    color: colorScheme.errorContainer,
                    onColor: colorScheme.onErrorContainer,
                    size: _colorChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'onErrorContainer',
                    color: colorScheme.onErrorContainer,
                    onColor: colorScheme.errorContainer,
                    showValue: showColorValue,
                  ),
                ],
              ),
              ColorGroup(
                children: <Widget>[
                  ColorChip(
                    label: 'surface',
                    color: colorScheme.surface,
                    onColor: colorScheme.onSurface,
                    size: _colorChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'onSurface',
                    color: colorScheme.onSurface,
                    onColor: colorScheme.surface,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'surfaceContainer',
                    color: colorScheme.surfaceContainer,
                    onColor: colorScheme.onSurfaceVariant,
                    size: _colorChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'onSurfaceVariant',
                    color: colorScheme.onSurfaceVariant,
                    onColor: colorScheme.surfaceContainer,
                    showValue: showColorValue,
                  ),
                ],
              ),
              ColorGroup(
                children: <Widget>[
                  ColorChip(
                    label: 'surfaceContainerLowest',
                    color: colorScheme.surfaceContainerLowest,
                    onColor: colorScheme.onSurface,
                    size: _equalFourChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'surfaceContainerLow',
                    color: colorScheme.surfaceContainerLow,
                    onColor: colorScheme.onSurface,
                    size: _equalFourChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'surfaceContainerHigh',
                    color: colorScheme.surfaceContainerHigh,
                    onColor: colorScheme.onSurface,
                    size: _equalFourChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'surfaceContainerHighest',
                    color: colorScheme.surfaceContainerHighest,
                    onColor: colorScheme.onSurface,
                    size: _equalFourChipSize,
                    showValue: showColorValue,
                  ),
                ],
              ),
              ColorGroup(
                children: <Widget>[
                  ColorChip(
                    label: 'surfaceDim',
                    color: colorScheme.surfaceDim,
                    onColor: colorScheme.onSurface,
                    size: _equalFourChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'surfaceBright',
                    color: colorScheme.surfaceBright,
                    onColor: colorScheme.onSurface,
                    size: _equalFourChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'inverseSurface',
                    color: colorScheme.inverseSurface,
                    onColor: colorScheme.onInverseSurface,
                    size: _equalFourChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'onInverseSurface',
                    color: colorScheme.onInverseSurface,
                    onColor: colorScheme.inverseSurface,
                    size: _equalFourChipSize,
                    showValue: showColorValue,
                  ),
                ],
              ),
              ColorGroup(
                children: <Widget>[
                  ColorChip(
                    label: 'outline',
                    color: colorScheme.outline,
                    onColor: colorScheme.surface,
                    size: _equalThreeChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'outlineVariant',
                    color: colorScheme.outlineVariant,
                    size: _equalThreeChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'scrim',
                    color: colorScheme.scrim,
                    size: _equalThreeChipSize,
                    showValue: showColorValue,
                  ),
                ],
              ),
              ColorGroup(
                children: <Widget>[
                  ColorChip(
                    label: 'surfaceTint',
                    color: colorScheme.surfaceTint,
                    size: _equalThreeChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'inversePrimary',
                    color: colorScheme.inversePrimary,
                    onColor: colorScheme.inverseSurface,
                    size: _equalThreeChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'shadow',
                    color: colorScheme.shadow,
                    size: _equalThreeChipSize,
                    showValue: showColorValue,
                  ),
                ],
              ),
              // TODO(rydmike): Remove deprecated colors in Flutter 3.25.
              // Show the deprecated colors.
              ColorGroup(
                children: <Widget>[
                  ColorChip(
                    label: 'background\n(deprecated)',
                    color: colorScheme.background,
                    onColor: colorScheme.onBackground,
                    size: _equalThreeChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'onBackground\n(deprecated)',
                    color: colorScheme.onBackground,
                    onColor: colorScheme.background,
                    size: _equalThreeChipSize,
                    showValue: showColorValue,
                  ),
                  ColorChip(
                    label: 'surfaceVariant\n(deprecated)',
                    color: colorScheme.surfaceVariant,
                    onColor: colorScheme.onSurfaceVariant,
                    size: _equalThreeChipSize,
                    showValue: showColorValue,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ColorGroup extends StatelessWidget {
  const ColorGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        surfaceTintColor: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class ColorChip extends StatelessWidget {
  const ColorChip({
    super.key,
    required this.color,
    required this.label,
    this.onColor,
    this.size,
    this.copyEnabled = true,
    this.showValue = false,
  });

  final Color color;
  final Color? onColor;
  final String label;
  final Size? size;
  final bool copyEnabled;
  final bool showValue;

  static Color _contrastColor(Color color) {
    final Brightness brightness = ThemeData.estimateBrightnessForColor(color);
    switch (brightness) {
      case Brightness.dark:
        return Colors.white;
      case Brightness.light:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color labelColor = onColor ?? _contrastColor(color);
    final Size effectiveSize = size ?? _onChipSize;

    return SizedBox(
      width: effectiveSize.width,
      height: effectiveSize.height,
      child: Tooltip(
        waitDuration: const Duration(milliseconds: 700),
        message: copyEnabled
            ? 'Color #${color.hexCode}.'
                '\nTap box to copy RGB value to Clipboard.'
            : '',
        child: ColoredBox(
          color: color,
          child: InkWell(
            onTap: copyEnabled
                ? () {
                    unawaited(copyColorToClipboard(context, color, label));
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      showValue ? '$label\n#${color.hexCode}' : label,
                      style: TextStyle(color: labelColor, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
