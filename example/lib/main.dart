import 'package:flutter/material.dart';

import 'about/views/about.dart';
import 'core/constants/app_data.dart';
import 'core/views/universal/showcase_material.dart';
import 'home/views/widgets/flex_tones_popup_menu.dart';
import 'home/views/widgets/show_color_scheme_colors.dart';
import 'home/views/widgets/show_key_colors.dart';
import 'theme/model/flex_tones_enum.dart';
import 'theme/model/selected_scheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.light;
  FlexTonesEnum usedTone = FlexTonesEnum.custom;
  int counter = 0;
  bool useSecondaryKey = true;
  bool useTertiaryKey = true;
  bool keepAllOnColorsBW = false;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ColorScheme from Seeds',
      themeMode: themeMode,
      // Make light and dark theme using seeded color color schemes, where
      // seeding type is selected via a function.
      theme: ThemeData.from(
        colorScheme: selectedSeedScheme(
          brightness: Brightness.light,
          tones: usedTone
              .tones(Brightness.light)
              .onMainsUseBW(keepAllOnColorsBW)
              .onSurfacesUseBW(keepAllOnColorsBW),
          useSecondaryKey: useSecondaryKey,
          useTertiaryKey: useTertiaryKey,
        ),
        useMaterial3: useMaterial3,
      ),
      darkTheme: ThemeData.from(
        colorScheme: selectedSeedScheme(
          brightness: Brightness.dark,
          tones: usedTone
              .tones(Brightness.dark)
              .onMainsUseBW(keepAllOnColorsBW)
              .onSurfacesUseBW(keepAllOnColorsBW),
          useSecondaryKey: useSecondaryKey,
          useTertiaryKey: useTertiaryKey,
        ),
        useMaterial3: useMaterial3,
      ),
      //
      // Define accessibility high contrast versions using same color base.
      //
      // The theme below is same as selecting the ultra contrast option in the
      // popup.
      //
      // By providing a theme on these properties, it will be auto selected
      // when platform accessibility theme is requested. Some host platforms
      // (for example, iOS, so far only iOS supports this in Flutter) allow the
      // users to increase contrast through an  accessibility setting.
      //
      // If the user requested a high contrast between foreground and background
      // content on iOS, via Settings -> Accessibility -> Increase Contrast.
      // This is currently only supported on iOS devices that are running
      // iOS 13 or above.
      //
      // If you make the selection on an iOS device, you will get the high
      // contrast scheme based ThemeData versions below, regardless of what
      // is selected in the popup in this demo app. This demonstrates how to
      // follow device accessibility setting on iOS, while still using a theme
      // with ColorScheme based on your theme design goal used for your standard
      // contrast.
      highContrastTheme: ThemeData.from(
        colorScheme: schemeLightHc,
        useMaterial3: useMaterial3,
      ),
      highContrastDarkTheme: ThemeData.from(
        colorScheme: schemeDarkHc,
        useMaterial3: useMaterial3,
      ),
      //
      //
      home: Scaffold(
        appBar: AppBar(
          title: Builder(builder: (BuildContext context) {
            return Text(AppData.title(context));
          }),
          actions: <Widget>[
            const AboutIconButton(),
            IconButton(
              icon: useMaterial3
                  ? const Icon(Icons.filter_3)
                  : const Icon(Icons.filter_2),
              onPressed: () {
                setState(() {
                  useMaterial3 = !useMaterial3;
                });
              },
              tooltip: 'Switch to Material ${useMaterial3 ? 2 : 3}',
            ),
            IconButton(
              icon: themeMode == ThemeMode.dark
                  ? const Icon(Icons.wb_sunny_outlined)
                  : const Icon(Icons.wb_sunny),
              onPressed: () {
                setState(() {
                  if (themeMode == ThemeMode.light) {
                    themeMode = ThemeMode.dark;
                  } else {
                    themeMode = ThemeMode.light;
                  }
                });
              },
              tooltip: 'Toggle brightness',
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            FlexTonesPopupMenu(
              title: 'Used FlexTones setup:',
              tone: usedTone,
              onChanged: (FlexTonesEnum? tone) {
                setState(() {
                  usedTone = tone ?? FlexTonesEnum.custom;
                });
              },
            ),
            ListTile(
              title: Text('${usedTone.toneLabel}'
                  ' FlexTones setup has CAM16 chroma:'),
              subtitle: Text('${usedTone.setup}\n'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ShowKeyColors(
                primaryKey: primarySeedColor,
                secondaryKey: secondarySeedColor,
                tertiaryKey: tertiarySeedColor,
              ),
            ),
            const ListTile(
                dense: true,
                title: Text('Primary key color is always used to seed the '
                    'ColorScheme')),
            SwitchListTile(
              dense: true,
              title:
                  const Text('Use secondary key color to seed the ColorScheme'),
              value: useSecondaryKey,
              onChanged: (bool value) {
                setState(() {
                  useSecondaryKey = value;
                });
              },
            ),
            SwitchListTile(
              dense: true,
              title:
                  const Text('Use tertiary key color to seed the ColorScheme'),
              value: useTertiaryKey,
              onChanged: (bool value) {
                setState(() {
                  useTertiaryKey = value;
                });
              },
            ),
            SwitchListTile(
              dense: true,
              title: const Text(
                  'Keep all onColors in seeded ColorScheme black and white'),
              value: keepAllOnColorsBW,
              onChanged: (bool value) {
                setState(() {
                  keepAllOnColorsBW = value;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ShowColorSchemeColors(),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              'You have pushed the (+) button this many times:',
              textAlign: TextAlign.center,
            ),
            Text(
              '$counter',
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            const ListTile(title: Text('Widget Showcase')),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: ShowcaseMaterial(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
