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
    final bool isLight = Theme.of(context).brightness == Brightness.light;
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
            title: 'Selected scheme variant:',
            variant: controller.usedVariant,
            onChanged: controller.setUsedTone,
            contentPadding:
                const EdgeInsetsDirectional.only(start: 16, end: 24),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ColorSchemeView(),
          ),
          ListTileSlider(
            dense: true,
            title: const Text('Contrast level. Only for MCU dynamic schemes'),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ShowTonalPalette(controller: controller),
          ),
          ListTile(
            title: Text('${controller.usedVariant.variantName}'
                ' scheme variant configuration info:'),
            subtitle: Text('${controller.usedVariant.configDetails}\n'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ShowInputColors(controller: controller),
          ),
          const ListTile(
              dense: true,
              title: Text('Primary key color is always used to seed the '
                  'ColorScheme. Tap to change colors.')),
          const Divider(),
          if (controller.usedVariant.isFlutterScheme)
            const ListTile(
              dense: true,
              title: Text('Additional seed generation options are not '
                  'available when using Flutter SDK scheme variant styles. '
                  'Use a variant based on FlexTones for more options.'),
            )
          else
            const ListTile(
              dense: true,
              title: Text('Additional seed generation options are available '
                  'when using FlexTones based scheme variants.'),
            ),
          SwitchListTile(
            dense: true,
            title:
                const Text('Use secondary key color to seed the ColorScheme'),
            value: controller.useSecondaryKey &&
                !controller.usedVariant.isFlutterScheme,
            onChanged: controller.usedVariant.isFlutterScheme
                ? null
                : controller.setUseSecondaryKey,
          ),
          SwitchListTile(
            dense: true,
            title: const Text('Use tertiary key color to seed the ColorScheme'),
            value: controller.useTertiaryKey &&
                !controller.usedVariant.isFlutterScheme,
            onChanged: controller.usedVariant.isFlutterScheme
                ? null
                : controller.setUseTertiaryKey,
          ),
          SwitchListTile(
            dense: true,
            title: const Text(
                'Use custom error key color to seed the ColorScheme'),
            value: controller.useErrorKey &&
                !controller.usedVariant.isFlutterScheme,
            onChanged: controller.usedVariant.isFlutterScheme
                ? null
                : controller.setUseErrorKey,
          ),
          const Divider(),
          SwitchListTile(
            dense: true,
            title: const Text(
                'Use monochrome surface colors, pure grey scale, no tint'),
            value: controller.useMonoSurfaces &&
                !controller.usedVariant.isFlutterScheme,
            onChanged: controller.usedVariant.isFlutterScheme
                ? null
                : controller.setUseMonoSurfaces,
          ),
          SwitchListTile(
            dense: true,
            title: const Text(
                'Keep main onColors in seeded ColorScheme black and white'),
            value: controller.keepMainOnColorsBW &&
                !controller.usedVariant.isFlutterScheme,
            onChanged: controller.usedVariant.isFlutterScheme
                ? null
                : controller.setKeepMainOnColorsBW,
          ),
          SwitchListTile(
            dense: true,
            title: const Text(
                'Keep surface onColors in seeded ColorScheme black and white'),
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
                  'white in seeded light ColorScheme'),
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
                  'black in seeded dark ColorScheme'),
              value: controller.keepDarkSurfaceColorsBlack &&
                  !controller.usedVariant.isFlutterScheme,
              onChanged: controller.usedVariant.isFlutterScheme
                  ? null
                  : controller.setKeepDarkSurfaceColorsBlack,
            ),
          const SizedBox(height: 16),
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
