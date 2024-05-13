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
  const ColorSchemeView({super.key, this.scheme});

  final ColorScheme? scheme;

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
                ),
                ColorChip(
                    label: 'onPrimary',
                    color: colorScheme.onPrimary,
                    onColor: colorScheme.primary),
                ColorChip(
                  label: 'primaryContainer',
                  color: colorScheme.primaryContainer,
                  onColor: colorScheme.onPrimaryContainer,
                  size: _colorChipSize,
                ),
                ColorChip(
                  label: 'onPrimaryContainer',
                  color: colorScheme.onPrimaryContainer,
                  onColor: colorScheme.primaryContainer,
                ),
              ]),
              ColorGroup(children: <Widget>[
                ColorChip(
                  label: 'primaryFixed',
                  color: colorScheme.primaryFixed,
                  onColor: colorScheme.onPrimaryFixed,
                  size: _colorChipSize,
                ),
                ColorChip(
                    label: 'onPrimaryFixed',
                    color: colorScheme.onPrimaryFixed,
                    onColor: colorScheme.primaryFixed),
                ColorChip(
                  label: 'primaryFixedDim',
                  color: colorScheme.primaryFixedDim,
                  onColor: colorScheme.onPrimaryFixedVariant,
                  size: _colorChipSize,
                ),
                ColorChip(
                  label: 'onPrimaryFixedVariant',
                  color: colorScheme.onPrimaryFixedVariant,
                  onColor: colorScheme.primaryFixedDim,
                ),
              ]),
              ColorGroup(children: <Widget>[
                ColorChip(
                  label: 'secondary',
                  color: colorScheme.secondary,
                  onColor: colorScheme.onSecondary,
                  size: _colorChipSize,
                ),
                ColorChip(
                  label: 'onSecondary',
                  color: colorScheme.onSecondary,
                  onColor: colorScheme.secondary,
                ),
                ColorChip(
                  label: 'secondaryContainer',
                  color: colorScheme.secondaryContainer,
                  onColor: colorScheme.onSecondaryContainer,
                  size: _colorChipSize,
                ),
                ColorChip(
                  label: 'onSecondaryContainer',
                  color: colorScheme.onSecondaryContainer,
                  onColor: colorScheme.secondaryContainer,
                ),
              ]),
              ColorGroup(children: <Widget>[
                ColorChip(
                  label: 'secondaryFixed',
                  color: colorScheme.secondaryFixed,
                  onColor: colorScheme.onSecondaryFixed,
                  size: _colorChipSize,
                ),
                ColorChip(
                    label: 'onSecondaryFixed',
                    color: colorScheme.onSecondaryFixed,
                    onColor: colorScheme.secondaryFixed),
                ColorChip(
                  label: 'secondaryFixedDim',
                  color: colorScheme.secondaryFixedDim,
                  onColor: colorScheme.onSecondaryFixedVariant,
                  size: _colorChipSize,
                ),
                ColorChip(
                  label: 'onSecondaryFixedVariant',
                  color: colorScheme.onSecondaryFixedVariant,
                  onColor: colorScheme.secondaryFixedDim,
                ),
              ]),
              ColorGroup(
                children: <Widget>[
                  ColorChip(
                    label: 'tertiary',
                    color: colorScheme.tertiary,
                    onColor: colorScheme.onTertiary,
                    size: _colorChipSize,
                  ),
                  ColorChip(
                    label: 'onTertiary',
                    color: colorScheme.onTertiary,
                    onColor: colorScheme.tertiary,
                  ),
                  ColorChip(
                    label: 'tertiaryContainer',
                    color: colorScheme.tertiaryContainer,
                    onColor: colorScheme.onTertiaryContainer,
                    size: _colorChipSize,
                  ),
                  ColorChip(
                    label: 'onTertiaryContainer',
                    color: colorScheme.onTertiaryContainer,
                    onColor: colorScheme.tertiaryContainer,
                  ),
                ],
              ),
              ColorGroup(children: <Widget>[
                ColorChip(
                  label: 'tertiaryFixed',
                  color: colorScheme.tertiaryFixed,
                  onColor: colorScheme.onTertiaryFixed,
                  size: _colorChipSize,
                ),
                ColorChip(
                    label: 'onTertiaryFixed',
                    color: colorScheme.onTertiaryFixed,
                    onColor: colorScheme.tertiaryFixed),
                ColorChip(
                  label: 'tertiaryFixedDim',
                  color: colorScheme.tertiaryFixedDim,
                  onColor: colorScheme.onTertiaryFixedVariant,
                  size: _colorChipSize,
                ),
                ColorChip(
                  label: 'onTertiaryFixedVariant',
                  color: colorScheme.onTertiaryFixedVariant,
                  onColor: colorScheme.tertiaryFixedDim,
                ),
              ]),
              ColorGroup(
                children: <Widget>[
                  ColorChip(
                    label: 'error',
                    color: colorScheme.error,
                    onColor: colorScheme.onError,
                    size: _colorChipSize,
                  ),
                  ColorChip(
                    label: 'onError',
                    color: colorScheme.onError,
                    onColor: colorScheme.error,
                  ),
                  ColorChip(
                    label: 'errorContainer',
                    color: colorScheme.errorContainer,
                    onColor: colorScheme.onErrorContainer,
                    size: _colorChipSize,
                  ),
                  ColorChip(
                    label: 'onErrorContainer',
                    color: colorScheme.onErrorContainer,
                    onColor: colorScheme.errorContainer,
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
                  ),
                  ColorChip(
                    label: 'onSurface',
                    color: colorScheme.onSurface,
                    onColor: colorScheme.surface,
                  ),
                  ColorChip(
                    label: 'surfaceContainer',
                    color: colorScheme.surfaceContainer,
                    onColor: colorScheme.onSurfaceVariant,
                    size: _colorChipSize,
                  ),
                  ColorChip(
                    label: 'onSurfaceVariant',
                    color: colorScheme.onSurfaceVariant,
                    onColor: colorScheme.surfaceContainer,
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
                  ),
                  ColorChip(
                    label: 'surfaceContainerLow',
                    color: colorScheme.surfaceContainerLow,
                    onColor: colorScheme.onSurface,
                    size: _equalFourChipSize,
                  ),
                  ColorChip(
                    label: 'surfaceContainerHigh',
                    color: colorScheme.surfaceContainerHigh,
                    onColor: colorScheme.onSurface,
                    size: _equalFourChipSize,
                  ),
                  ColorChip(
                    label: 'surfaceContainerHighest',
                    color: colorScheme.surfaceContainerHighest,
                    onColor: colorScheme.onSurface,
                    size: _equalFourChipSize,
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
                  ),
                  ColorChip(
                    label: 'surfaceBright',
                    color: colorScheme.surfaceBright,
                    onColor: colorScheme.onSurface,
                    size: _equalFourChipSize,
                  ),
                  ColorChip(
                    label: 'inverseSurface',
                    color: colorScheme.inverseSurface,
                    onColor: colorScheme.onInverseSurface,
                    size: _equalFourChipSize,
                  ),
                  ColorChip(
                    label: 'onInverseSurface',
                    color: colorScheme.onInverseSurface,
                    onColor: colorScheme.inverseSurface,
                    size: _equalFourChipSize,
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
                  ),
                  ColorChip(
                    label: 'outlineVariant',
                    color: colorScheme.outlineVariant,
                    size: _equalThreeChipSize,
                  ),
                  ColorChip(
                    label: 'scrim',
                    color: colorScheme.scrim,
                    size: _equalThreeChipSize,
                  ),
                ],
              ),
              ColorGroup(
                children: <Widget>[
                  ColorChip(
                    label: 'surfaceTint',
                    color: colorScheme.surfaceTint,
                    size: _equalThreeChipSize,
                  ),
                  ColorChip(
                    label: 'inversePrimary',
                    color: colorScheme.inversePrimary,
                    onColor: colorScheme.primary,
                    size: _equalThreeChipSize,
                  ),
                  ColorChip(
                    label: 'shadow',
                    color: colorScheme.shadow,
                    size: _equalThreeChipSize,
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
                  ),
                  ColorChip(
                    label: 'onBackground\n(deprecated)',
                    color: colorScheme.onBackground,
                    onColor: colorScheme.background,
                    size: _equalThreeChipSize,
                  ),
                  ColorChip(
                    label: 'surfaceVariant\n(deprecated)',
                    color: colorScheme.surfaceVariant,
                    onColor: colorScheme.onSurfaceVariant,
                    size: _equalThreeChipSize,
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
  });

  final Color color;
  final Color? onColor;
  final String label;
  final Size? size;
  final bool copyEnabled;

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
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      label,
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
