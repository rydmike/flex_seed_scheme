import 'package:flutter/material.dart';

import '../../../about/views/about.dart';
import '../../../core/constants/app_data.dart';
import '../../../core/views/universal/showcase_material.dart';
import '../../../theme/controllers/theme_controller.dart';
import '../widgets/flex_tones_popup_menu.dart';
import '../widgets/show_color_scheme_colors.dart';
import '../widgets/show_key_colors.dart';
import '../widgets/show_tonal_palette.dart';

/// The home page of this custom seed generated color scheme demo.
///
/// Takes a [ThemeController] used to control theme settings.
class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
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
            title: 'Used FlexTones setup:',
            tone: controller.usedTone,
            onChanged: controller.setUsedTone,
          ),
          ListTile(
            title: Text('${controller.usedTone.toneLabel}'
                ' FlexTones setup has CAM16 chroma:'),
            subtitle: Text('${controller.usedTone.setup}\n'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ShowKeyColors(controller: controller),
          ),
          const ListTile(
              dense: true,
              title: Text('Primary key color is always used to seed the '
                  'ColorScheme')),
          const Divider(),
          SwitchListTile(
            dense: true,
            title:
                const Text('Use secondary key color to seed the ColorScheme'),
            value: controller.useSecondaryKey,
            onChanged: controller.setUseSecondaryKey,
          ),
          SwitchListTile(
            dense: true,
            title: const Text('Use tertiary key color to seed the ColorScheme'),
            value: controller.useTertiaryKey,
            onChanged: controller.setUseTertiaryKey,
          ),
          const Divider(),
          SwitchListTile(
            dense: true,
            title: const Text(
                'Keep main onColors in seeded ColorScheme black and white'),
            value: controller.keepMainOnColorsBW,
            onChanged: controller.setKeepMainOnColorsBW,
          ),
          SwitchListTile(
            dense: true,
            title: const Text(
                'Keep surface onColors in seeded ColorScheme black and white'),
            value: controller.keepSurfaceOnColorsBW,
            onChanged: controller.setKeepSurfaceOnColorsBW,
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ShowTonalPalette(controller: controller),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ShowColorSchemeColors(),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const ListTile(title: Text('Widget Showcase')),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: ShowcaseMaterial(),
          ),
        ],
      ),
    );
  }
}
