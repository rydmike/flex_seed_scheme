import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flex_seed_scheme_example/about/views/about.dart';
import 'package:flex_seed_scheme_example/core/constants/app_data.dart';
import 'package:flex_seed_scheme_example/core/utils/effective_flex_tones.dart';
import 'package:flex_seed_scheme_example/core/views/universal/color_scheme_view.dart';
import 'package:flex_seed_scheme_example/core/views/universal/list_tile_slider.dart';
import 'package:flex_seed_scheme_example/core/views/universal/showcase_material.dart';
import 'package:flex_seed_scheme_example/core/views/universal/switch_list_tile_reveal.dart';
import 'package:flex_seed_scheme_example/home/views/widgets/flex_tones_popup_menu.dart';
import 'package:flex_seed_scheme_example/home/views/widgets/show_input_colors.dart';
import 'package:flex_seed_scheme_example/home/views/widgets/show_tonal_palette.dart';
import 'package:flex_seed_scheme_example/theme/controllers/theme_controller.dart';
import 'package:material_ui/material_ui.dart';

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
    const EdgeInsetsDirectional paddingStartColumn = EdgeInsetsDirectional.only(start: 16, end: 8);
    final EdgeInsetsDirectional paddingEndColumn = EdgeInsetsDirectional.only(
      start: 8,
      end: theme.useMaterial3 ? 24 : 16,
    );

    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (BuildContext context) {
            return Text(AppData.title(context));
          },
        ),
        actions: <Widget>[
          const AboutIconButton(),
          IconButton(
            icon: controller.useMaterial3 ? const Icon(Icons.filter_3) : const Icon(Icons.filter_2),
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
            contentPadding: const EdgeInsetsDirectional.only(start: 16, end: 24),
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
                    'light mode. This is a newer Material-3 spec standard. It '
                    'is more color expressive, but reduces contrast.\n'
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
                    'This style is used by ColorScheme.fromSeed in Flutter '
                    'stable 3.44 and later, that use Material Color Utilities '
                    '(MCU) v0.13.0, where it is the only option, there is no '
                    'opt-out.\n'
                    '\n'
                    'FlexSeedScheme version 4.0.0 or later, uses this new '
                    'style by default. In earlier versions of FlexSeedScheme '
                    'you had to opt-in to use this style. Now you instead have '
                    'to opt-out of it if you prefer the older style.\n'
                    '\n'
                    'Unlike Flutter, FlexSeedScheme still offers this opt-out '
                    'and lets you keep using the legacy non-expressive '
                    'on-color style in light mode, with its higher '
                    'contrast.\n'
                    '\n'
                    'For MCU seed generated schemes, this only has any impact '
                    'when contrast level is at the default value (0), normal '
                    'contrast.\n'
                    '\n'
                    'When using FSS seed generated schemes, the tones modifier '
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
            subtitle: const Text(
              'Only available for MCU dynamic schemes.\n'
              'Levels in M3 guide 0: Normal, 0.5: Medium, 1: High',
            ),
            enabled: controller.usedVariant.isFlutterScheme,
            min: -1,
            max: 1,
            divisions: 8,
            valueDecimals: 2,
            value: controller.usedVariant.isFlutterScheme ? controller.contrastLevel : 0,
            onChanged: controller.setContrastLevel,
            sliderLabel: 'Contrast',
          ),
          const Divider(),
          if (controller.usedVariant.isFlutterScheme)
            const ListTile(
              dense: true,
              title: Text(
                'Additional seed generation options are not '
                'available when using Flutter MCU dynamic scheme variants. '
                'Use a variant based on FSS FlexTones for more options.',
              ),
            )
          else
            const ListTile(
              dense: true,
              title: Text(
                'Additional seed generation options are available '
                'when using FSS FlexTones based scheme variants.',
              ),
            ),
          SwitchListTile(
            dense: true,
            title: const Text('Monochrome surfaces, pure grey scale, no tint '),
            subtitle: const Text('tones.monochromeSurfaces()'),
            value: controller.useMonoSurfaces && !controller.usedVariant.isFlutterScheme,
            onChanged: controller.usedVariant.isFlutterScheme ? null : controller.setUseMonoSurfaces,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: SwitchListTile(
                  contentPadding: paddingStartColumn,
                  dense: true,
                  title: const Text('Higher contrast fixed colors'),
                  subtitle: const Text('tones.higherContrastFixed()'),
                  value: controller.higherContrastFixedColors && !controller.usedVariant.isFlutterScheme,
                  onChanged: controller.usedVariant.isFlutterScheme ? null : controller.setHigherContrastFixedColors,
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  contentPadding: paddingEndColumn,
                  dense: true,
                  title: const Text('Keep main on-colors black and white'),
                  subtitle: const Text('tones.onMainsUseBW()'),
                  value: controller.keepMainOnColorsBW && !controller.usedVariant.isFlutterScheme,
                  onChanged: controller.usedVariant.isFlutterScheme ? null : controller.setKeepMainOnColorsBW,
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
                  value: controller.keepSurfaceOnColorsBW && !controller.usedVariant.isFlutterScheme,
                  onChanged: controller.usedVariant.isFlutterScheme ? null : controller.setKeepSurfaceOnColorsBW,
                ),
              ),
              if (isLight)
                Expanded(
                  child: SwitchListTile(
                    contentPadding: paddingEndColumn,
                    dense: true,
                    title: const Text('Keep surface color white in light scheme'),
                    subtitle: const Text('tones.surfacesUseBW()'),
                    value: controller.keepLightSurfaceColorsWhite && !controller.usedVariant.isFlutterScheme,
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
                    title: const Text('Keep surface color black in dark scheme'),
                    subtitle: const Text('tones.surfacesUseBW()'),
                    value: controller.keepDarkSurfaceColorsBlack && !controller.usedVariant.isFlutterScheme,
                    onChanged: controller.usedVariant.isFlutterScheme ? null : controller.setKeepDarkSurfaceColorsBlack,
                  ),
                ),
            ],
          ),
          const Divider(),
          const ListTile(title: Text('Widget showcase, using Material default styles')),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ShowcaseMaterial(),
          ),
        ],
      ),
    );
  }
}
