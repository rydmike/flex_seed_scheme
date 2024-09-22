import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import '../../../about/views/about.dart';
import '../../../core/constants/app_data.dart';
import '../../../core/utils/effective_flex_tones.dart';
import '../../../core/views/universal/color_scheme_view.dart';
import '../../../core/views/universal/list_tile_slider.dart';
import '../../../core/views/universal/showcase_material.dart';
import '../../../core/views/universal/switch_list_tile_reveal.dart';
import '../../../theme/controllers/theme_controller.dart';
import '../widgets/flex_tones_popup_menu.dart';
import '../widgets/show_input_colors.dart';
import '../widgets/show_tonal_palette.dart';

/// The home page of this custom seed generated color scheme demo.
///
/// Takes a [ThemeController] used to control theme settings.
class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Brightness brightness = theme.brightness;
    final bool isLight = brightness == Brightness.light;

    // Get effective tones and chroma setup
    final FlexTones tones = effectiveFlexTones(controller, context);

    // Paddings for the two column control layouts.
    const EdgeInsetsDirectional paddingStartColumn =
        EdgeInsetsDirectional.only(start: 16, end: 8);
    final EdgeInsetsDirectional paddingEndColumn =
        EdgeInsetsDirectional.only(start: 8, end: theme.useMaterial3 ? 24 : 16);

    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (BuildContext context) {
          return Text(AppData.title(context));
        }),
        actions: <Widget>[
          const AboutIconButton(),
          IconButton(
            icon: controller.useMaterial3
                ? const Icon(Icons.filter_3)
                : const Icon(Icons.filter_2),
            onPressed: () {
              controller.setUseMaterial3(!controller.useMaterial3);
            },
            tooltip: 'Switch to Material ${controller.useMaterial3 ? 2 : 3}',
          ),
          IconButton(
            icon: controller.themeMode == ThemeMode.dark
                ? const Icon(Icons.wb_sunny_outlined)
                : const Icon(Icons.wb_sunny),
            onPressed: () {
              if (controller.themeMode == ThemeMode.light) {
                controller.setThemeMode(ThemeMode.dark);
              } else {
                controller.setThemeMode(ThemeMode.light);
              }
            },
            tooltip: 'Toggle brightness',
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          FlexTonesPopupMenu(
            title: 'ColorScheme seed strategy:',
            variant: controller.usedVariant,
            onChanged: controller.setUsedTone,
            contentPadding:
                const EdgeInsetsDirectional.only(start: 16, end: 24),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ShowInputColors(controller: controller),
          ),
          SwitchListTile(
            title: const Text('ColorScheme'),
            subtitle: const Text('Show color values'),
            value: controller.showColorValue,
            onChanged: controller.setShowColorValue,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ColorSchemeView(
              showColorValue: controller.showColorValue,
              tones: tones,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ShowTonalPalette(controller: controller),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SwitchListTileReveal(
                  contentPadding: paddingStartColumn,
                  dense: true,
                  title: const Text('Use expressive container on-colors'),
                  subtitleReveal: const Text(
                    'Use tone 30 instead of 10 for onColors on containers in '
                    'light mode. This is a new Material-3 spec standard. It is '
                    'more color expressive, but reduces contrast.\n'
                    '\n'
                    'This modifier only impacts light scheme variants where '
                    'the container on colors use tone 10. For scheme variants '
                    'with an intentionally custom tone for onColors on '
                    'containers, this setting has no impact. Such variants '
                    'are:\n'
                    ' - Fidelity\n'
                    ' - Monochrome\n'
                    ' - Content\n'
                    ' - Ultra Contrast\n'
                    ' - Candy pop\n'
                    ' - Chroma\n'
                    '\n'
                    "This feature is not yet used by Flutter's "
                    'ColorScheme.fromSeed produced ColorSchemes, but will be '
                    'when Flutter upgrades to Material Color Utilities (MCU) '
                    'v0.12.0. You can opt in on using it already now, or '
                    'decide not to use it. With FSS you will be able to do so, '
                    'even after it becomes a forced default and the only '
                    "option in Flutter's ColorScheme.fromSeed.\n"
                    '\n'
                    'For MCU seed generated schemes, this only has any impact '
                    'when contrast level is at the default value (0), normal '
                    'contrast.\n'
                    '\n'
                    'When using FFS seed generated schemes, the tones modifier '
                    '"B&W main onColors" will override this setting.\n',
                  ),
                  value: controller.useExpressiveOn,
                  onChanged: controller.setUseExpressiveOn,
                ),
              ),
              Expanded(
                child: SwitchListTileReveal(
                  contentPadding: paddingEndColumn,
                  dense: true,
                  title: const Text('Respect monochrome seed colors'),
                  subtitleReveal: const Text(
                    'Previously in FSS and in Material Color Utilities (MCU), '
                    "and thus Flutter's default, using a monochrome seed "
                    'value or white, results in a tonal palette with cyan '
                    'color tones. A black input results in red like color '
                    'tones. This is not very intuitive and not really '
                    'expected by most users of monochrome seed colors.\n',
                  ),
                  value: controller.respectMonochromeSeed,
                  onChanged: controller.setRespectMonochromeSeed,
                ),
              ),
            ],
          ),
          ListTileSlider(
            dense: true,
            title: const Text('Contrast level'),
            subtitle: const Text('Only available for MCU dynamic schemes.\n'
                'Levels in M3 guide 0: Normal, 0.5: Medium, 1: High'),
            enabled: controller.usedVariant.isFlutterScheme,
            min: -1,
            max: 1,
            divisions: 8,
            valueDecimals: 2,
            value: controller.usedVariant.isFlutterScheme
                ? controller.contrastLevel
                : 0,
            onChanged: controller.setContrastLevel,
            sliderLabel: 'Contrast',
          ),
          const Divider(),
          if (controller.usedVariant.isFlutterScheme)
            const ListTile(
              dense: true,
              title: Text('Additional seed generation options are not '
                  'available when using Flutter MCU dynamic scheme variants. '
                  'Use a variant based on FSS FlexTones for more options.'),
            )
          else
            const ListTile(
              dense: true,
              title: Text('Additional seed generation options are available '
                  'when using FSS FlexTones based scheme variants.'),
            ),
          SwitchListTile(
            dense: true,
            title: const Text('Monochrome surfaces, pure grey scale, no tint '),
            subtitle: const Text('tones.monochromeSurfaces()'),
            value: controller.useMonoSurfaces &&
                !controller.usedVariant.isFlutterScheme,
            onChanged: controller.usedVariant.isFlutterScheme
                ? null
                : controller.setUseMonoSurfaces,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: SwitchListTile(
                  contentPadding: paddingStartColumn,
                  dense: true,
                  title: const Text('Higher contrast fixed colors'),
                  subtitle: const Text('tones.higherContrastFixed()'),
                  value: controller.higherContrastFixedColors &&
                      !controller.usedVariant.isFlutterScheme,
                  onChanged: controller.usedVariant.isFlutterScheme
                      ? null
                      : controller.setHigherContrastFixedColors,
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  contentPadding: paddingEndColumn,
                  dense: true,
                  title: const Text('Keep main on-colors black and white'),
                  subtitle: const Text('tones.onMainsUseBW()'),
                  value: controller.keepMainOnColorsBW &&
                      !controller.usedVariant.isFlutterScheme,
                  onChanged: controller.usedVariant.isFlutterScheme
                      ? null
                      : controller.setKeepMainOnColorsBW,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: SwitchListTile(
                  contentPadding: paddingStartColumn,
                  dense: true,
                  title: const Text('Keep surface on-colors black and white'),
                  subtitle: const Text('tones.onSurfacesUseBW()'),
                  value: controller.keepSurfaceOnColorsBW &&
                      !controller.usedVariant.isFlutterScheme,
                  onChanged: controller.usedVariant.isFlutterScheme
                      ? null
                      : controller.setKeepSurfaceOnColorsBW,
                ),
              ),
              if (isLight)
                Expanded(
                  child: SwitchListTile(
                    contentPadding: paddingEndColumn,
                    dense: true,
                    title:
                        const Text('Keep surface color white in light scheme'),
                    subtitle: const Text('tones.surfacesUseBW()'),
                    value: controller.keepLightSurfaceColorsWhite &&
                        !controller.usedVariant.isFlutterScheme,
                    onChanged: controller.usedVariant.isFlutterScheme
                        ? null
                        : controller.setKeepLightSurfaceColorsWhite,
                  ),
                )
              else
                Expanded(
                  child: SwitchListTile(
                    contentPadding: paddingEndColumn,
                    dense: true,
                    title:
                        const Text('Keep surface color black in dark scheme'),
                    subtitle: const Text('tones.surfacesUseBW()'),
                    value: controller.keepDarkSurfaceColorsBlack &&
                        !controller.usedVariant.isFlutterScheme,
                    onChanged: controller.usedVariant.isFlutterScheme
                        ? null
                        : controller.setKeepDarkSurfaceColorsBlack,
                  ),
                ),
            ],
          ),
          const Divider(),
          const ListTile(
              title: Text('Widget showcase, using Material default styles')),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ShowcaseMaterial(),
          ),
        ],
      ),
    );
  }
}
