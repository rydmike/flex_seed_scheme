import 'package:flutter/material.dart';

import '../../../core/views/app/color_name_value.dart';
import '../../../core/views/app/color_picker_inkwell.dart';
import '../../../theme/controllers/theme_controller.dart';

// Display the colors in currently selected input color scheme, including
// their name and color code.
//
// Allow user to edit the colors, if we are we are viewing the last color
// scheme, which is the custom color scheme.
class ShowInputColors extends StatelessWidget {
  const ShowInputColors({
    super.key,
    required this.controller,
  });

  final ThemeController controller;

  // Return true if the color is light, meaning it needs dark text for contrast.
  static bool _isLight(final Color color) =>
      ThemeData.estimateBrightnessForColor(color) == Brightness.light;

  // On color used when a theme color property does not have a theme onColor.
  static Color _onColor(final Color color) =>
      _isLight(color) ? Colors.black : Colors.white;

  @override
  Widget build(BuildContext context) {
    // Size of theme color presentation boxes
    const double boxWidth = 150;
    const double boxHeight = 80;

    // Theme values...
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool useMaterial3 = theme.useMaterial3;
    // These color values are also used if picking is cancelled to restore
    // previous color selection.
    final Color primary = controller.primarySeedColor;
    final Color onPrimary = _onColor(primary);
    final Color secondary = controller.secondarySeedColor;
    final Color onSecondary = _onColor(secondary);
    final Color tertiary = controller.tertiarySeedColor;
    final Color onTertiary = _onColor(tertiary);
    final Color error = controller.errorSeedColor;
    final Color onError = _onColor(error);
    final Color neutrals = controller.neutralSeedColor;
    final Color onNeutrals = _onColor(neutrals);

    final Color surface = colorScheme.surface;

    // Grab the card border from the theme card shape
    ShapeBorder? border = theme.cardTheme.shape;
    // If we had one, copy in a border side to it.
    if (border is RoundedRectangleBorder) {
      border = border.copyWith(
        side: BorderSide(
          color: theme.dividerColor,
          width: 1,
        ),
      );
      // else
    } else {
      // If border was null, make one matching Card default, but with border
      // side, if it was not null, we leave it as it was.
      border ??= RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(useMaterial3 ? 12 : 4)),
        side: BorderSide(
          color: theme.dividerColor,
          width: 1,
        ),
      );
    }
    // Wrap this widget branch in a custom theme where card has a border outline
    // if it did not have one, but retains in ambient themed border radius.
    return Theme(
      data: theme.copyWith(
        cardTheme: CardTheme.of(context).copyWith(
          elevation: 0,
          shape: border,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Key colors used to seed the ColorScheme',
              style: theme.textTheme.titleMedium,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              // Primary color
              Column(
                children: <Widget>[
                  RepaintBoundary(
                    key: const ValueKey<String>('input_primary'),
                    child: SizedBox(
                      width: boxWidth,
                      height: boxHeight,
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        clipBehavior: Clip.hardEdge,
                        child: Material(
                          color: primary,
                          child: ColorPickerInkWellDialog(
                            color: primary,
                            tonalPaletteFixedMinChroma:
                                controller.respectMonochromeSeed,
                            onChanged: controller.setPrimarySeedColor,
                            recentColors: controller.recentColors,
                            onRecentColorsChanged: controller.setRecentColors,
                            wasCancelled: (bool cancelled) {
                              if (cancelled) {
                                controller.setPrimarySeedColor(primary);
                              }
                            },
                            enabled: true,
                            child: ColorNameValue(
                              key: ValueKey<String>('ipc primary $primary'),
                              color: primary,
                              textColor: onPrimary,
                              label: 'primary',
                              showInputColor: false,
                              showMaterialName: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: boxWidth,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      dense: true,
                      title: Text('Use seed color'),
                    ),
                  ),
                  SizedBox(
                    width: boxWidth,
                    child: SwitchListTile(
                      activeColor: colorScheme.primary,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      dense: true,
                      title: const Text('Pinned'),
                      value: controller.pinPrimary,
                      onChanged: controller.setPinPrimary,
                    ),
                  ),
                ],
              ),
              // Secondary color
              Column(
                children: <Widget>[
                  RepaintBoundary(
                    key: const ValueKey<String>('input_secondary'),
                    child: SizedBox(
                      width: boxWidth,
                      height: boxHeight,
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        clipBehavior: Clip.hardEdge,
                        child: Material(
                          color:
                              controller.useSecondaryKey ? secondary : surface,
                          child: ColorPickerInkWellDialog(
                            color: secondary,
                            tonalPaletteFixedMinChroma:
                                controller.respectMonochromeSeed,
                            onChanged: controller.setSecondarySeedColor,
                            recentColors: controller.recentColors,
                            onRecentColorsChanged: controller.setRecentColors,
                            wasCancelled: (bool cancelled) {
                              if (cancelled) {
                                controller.setSecondarySeedColor(secondary);
                              }
                            },
                            enabled: controller.useSecondaryKey,
                            child: ColorNameValue(
                              key: ValueKey<String>('ipc secondary $secondary'),
                              color: controller.useSecondaryKey
                                  ? secondary
                                  : surface,
                              textColor: controller.useSecondaryKey
                                  ? onSecondary
                                  : surface,
                              showInputColor: false,
                              label: 'secondary',
                              showMaterialName: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: boxWidth,
                    child: SwitchListTile(
                      activeColor: colorScheme.secondary,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      dense: true,
                      title: const Text('Secondary'),
                      value: controller.useSecondaryKey,
                      onChanged: controller.setUseSecondaryKey,
                    ),
                  ),
                  SizedBox(
                    width: boxWidth,
                    child: SwitchListTile(
                      activeColor: colorScheme.secondary,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      dense: true,
                      title: const Text('Pinned'),
                      value: controller.pinSecondary,
                      onChanged: controller.useSecondaryKey
                          ? controller.setPinSecondary
                          : null,
                    ),
                  ),
                ],
              ),

              // Tertiary color
              Column(
                children: <Widget>[
                  RepaintBoundary(
                    key: const ValueKey<String>('input_tertiary'),
                    child: SizedBox(
                      width: boxWidth,
                      height: boxHeight,
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        clipBehavior: Clip.hardEdge,
                        child: Material(
                          color: controller.useTertiaryKey ? tertiary : surface,
                          child: ColorPickerInkWellDialog(
                            color:
                                controller.useTertiaryKey ? tertiary : surface,
                            tonalPaletteFixedMinChroma:
                                controller.respectMonochromeSeed,
                            onChanged: controller.setTertiarySeedColor,
                            recentColors: controller.recentColors,
                            onRecentColorsChanged: controller.setRecentColors,
                            wasCancelled: (bool cancelled) {
                              if (cancelled) {
                                controller.setTertiarySeedColor(tertiary);
                              }
                            },
                            enabled: controller.useTertiaryKey,
                            child: ColorNameValue(
                              key: ValueKey<String>('ipc tertiary $tertiary'),
                              color: controller.useTertiaryKey
                                  ? tertiary
                                  : surface,
                              textColor: controller.useTertiaryKey
                                  ? onTertiary
                                  : surface,
                              label: 'tertiary',
                              showInputColor: false,
                              showMaterialName: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: boxWidth,
                    child: SwitchListTile(
                      activeColor: colorScheme.tertiary,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      dense: true,
                      title: const Text('Tertiary'),
                      value: controller.useTertiaryKey,
                      onChanged: controller.setUseTertiaryKey,
                    ),
                  ),
                  SizedBox(
                    width: boxWidth,
                    child: SwitchListTile(
                      activeColor: colorScheme.tertiary,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      dense: true,
                      title: const Text('Pinned'),
                      value: controller.pinTertiary,
                      onChanged: controller.useTertiaryKey
                          ? controller.setPinTertiary
                          : null,
                    ),
                  ),
                ],
              ),
              // Error color
              Column(
                children: <Widget>[
                  RepaintBoundary(
                    key: const ValueKey<String>('input_error'),
                    child: SizedBox(
                      width: boxWidth,
                      height: boxHeight,
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        clipBehavior: Clip.hardEdge,
                        child: Material(
                          color: controller.useErrorKey ? error : surface,
                          child: ColorPickerInkWellDialog(
                            color: controller.useErrorKey ? error : surface,
                            tonalPaletteFixedMinChroma:
                                controller.respectMonochromeSeed,
                            onChanged: controller.setErrorSeedColor,
                            recentColors: controller.recentColors,
                            onRecentColorsChanged: controller.setRecentColors,
                            wasCancelled: (bool cancelled) {
                              if (cancelled) {
                                controller.setErrorSeedColor(error);
                              }
                            },
                            enabled: controller.useErrorKey,
                            child: ColorNameValue(
                              key: ValueKey<String>('ipc error $error'),
                              color: controller.useErrorKey ? error : surface,
                              textColor:
                                  controller.useErrorKey ? onError : surface,
                              label: 'error',
                              showInputColor: false,
                              showMaterialName: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: boxWidth,
                    child: SwitchListTile(
                      activeColor: colorScheme.error,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      dense: true,
                      title: const Text('Error'),
                      value: controller.useErrorKey,
                      onChanged: controller.setUseErrorKey,
                    ),
                  ),
                  SizedBox(
                    width: boxWidth,
                    child: SwitchListTile(
                      activeColor: colorScheme.error,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      dense: true,
                      title: const Text('Pinned'),
                      value: controller.pinError,
                      onChanged: controller.useErrorKey
                          ? controller.setPinError
                          : null,
                    ),
                  ),
                ],
              ),
              // Neutral color
              Column(
                children: <Widget>[
                  RepaintBoundary(
                    key: const ValueKey<String>('input_neutral'),
                    child: SizedBox(
                      width: boxWidth,
                      height: boxHeight,
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        clipBehavior: Clip.hardEdge,
                        child: Material(
                          color: controller.useNeutralKey ? neutrals : surface,
                          child: ColorPickerInkWellDialog(
                            color:
                                controller.useNeutralKey ? neutrals : surface,
                            tonalPaletteFixedMinChroma:
                                controller.respectMonochromeSeed,
                            onChanged: controller.setNeutralSeedColor,
                            recentColors: controller.recentColors,
                            onRecentColorsChanged: controller.setRecentColors,
                            wasCancelled: (bool cancelled) {
                              if (cancelled) {
                                controller.setNeutralSeedColor(neutrals);
                              }
                            },
                            enabled: controller.useNeutralKey,
                            child: ColorNameValue(
                              key: ValueKey<String>('ipc neutral $neutrals'),
                              color:
                                  controller.useNeutralKey ? neutrals : surface,
                              textColor: controller.useNeutralKey
                                  ? onNeutrals
                                  : surface,
                              label: 'surfaces',
                              showInputColor: false,
                              showMaterialName: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: boxWidth,
                    child: SwitchListTile(
                      activeColor: colorScheme.outline,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      dense: true,
                      title: const Text('Surfaces'),
                      value: controller.useNeutralKey,
                      onChanged: controller.setUseNeutralKey,
                    ),
                  ),
                  const SizedBox(
                    width: boxWidth,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      dense: true,
                      title: Text('Also surfaceTint'),
                    ),
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
