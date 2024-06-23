import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import '../../../about/views/about.dart';
import '../../../core/constants/app_data.dart';
import '../../../core/views/universal/color_scheme_view.dart';
import '../../../core/views/universal/list_tile_slider.dart';
import '../../../core/views/universal/showcase_material.dart';
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
    final Brightness brightness = Theme.of(context).brightness;
    final bool isLight = brightness == Brightness.light;

    final FlexTones tones = controller.usedVariant.isFlutterScheme
        ? FlexTones.material(brightness)
            .expressiveOnContainer(controller.useExpressiveOn)
        : controller.usedVariant
            .tones(brightness)
            .monochromeSurfaces(controller.useMonoSurfaces)
            .onMainsUseBW(controller.keepMainOnColorsBW)
            .onSurfacesUseBW(controller.keepSurfaceOnColorsBW)
            .surfacesUseBW(isLight
                ? controller.keepLightSurfaceColorsWhite
                : controller.keepDarkSurfaceColorsBlack)
            .expressiveOnContainer(controller.useExpressiveOn);

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
          SwitchListTile(
            dense: true,
            title: const Text('Use expressive on-colors on light containers'),
            value: controller.useExpressiveOn,
            onChanged: controller.setUseExpressiveOn,
          ),
          const ListTile(
            dense: true,
            title: Text('Some MCU based seed strategies, like Fidelity and '
                'Content, dynamically adjust '
                'tones for contrast, this also applies when using contrast '
                'level. The shown baseline tone mappings are not always used '
                'when using MCU dynamic schemes'),
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
          SwitchListTile(
            dense: true,
            title: const Text('Keep main on-colors black and white'),
            subtitle: const Text('tones.onMainsUseBW()'),
            value: controller.keepMainOnColorsBW &&
                !controller.usedVariant.isFlutterScheme,
            onChanged: controller.usedVariant.isFlutterScheme
                ? null
                : controller.setKeepMainOnColorsBW,
          ),
          SwitchListTile(
            dense: true,
            title: const Text('Keep surface on-colors black and white'),
            subtitle: const Text('tones.onSurfacesUseBW()'),
            value: controller.keepSurfaceOnColorsBW &&
                !controller.usedVariant.isFlutterScheme,
            onChanged: controller.usedVariant.isFlutterScheme
                ? null
                : controller.setKeepSurfaceOnColorsBW,
          ),
          if (isLight)
            SwitchListTile(
              dense: true,
              title: const Text('Keep surface and deprecated background color, '
                  'white in light scheme'),
              subtitle: const Text('tones.surfacesUseBW()'),
              value: controller.keepLightSurfaceColorsWhite &&
                  !controller.usedVariant.isFlutterScheme,
              onChanged: controller.usedVariant.isFlutterScheme
                  ? null
                  : controller.setKeepLightSurfaceColorsWhite,
            )
          else
            SwitchListTile(
              dense: true,
              title: const Text('Keep surface and deprecated background color, '
                  'black in dark scheme'),
              subtitle: const Text('tones.surfacesUseBW()'),
              value: controller.keepDarkSurfaceColorsBlack &&
                  !controller.usedVariant.isFlutterScheme,
              onChanged: controller.usedVariant.isFlutterScheme
                  ? null
                  : controller.setKeepDarkSurfaceColorsBlack,
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
