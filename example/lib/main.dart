import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import 'flex_tones_enum.dart';
import 'flex_tones_popup_menu.dart';
import 'show_color_scheme_colors.dart';

// Define your seed colors.
const Color primarySeedColor = Color(0xFF6750A4);
const Color secondarySeedColor = Color(0xFF3871BB);
const Color tertiarySeedColor = Color(0xFF6CA450);

// Return a ColorScheme from the fixed seeds for primary, secondary and tertiary
// keys colors, at given brightness and provided tones FlexTones,
ColorScheme selectedSeedScheme(
  Brightness brightness,
  FlexTones tones,
) =>
    SeedColorScheme.fromSeeds(
      brightness: brightness,
      // Primary key color is required, like seed color ColorScheme.fromSeed.
      primaryKey: primarySeedColor,
      // You can add optional own seeds for secondary and tertiary key colors.
      // To see the real diff between M3 default result, we are not going to
      // use the secondary and tertiary keys, if used tones mapping
      // is equal to FlexTones.material, although you can of course, but then
      // the result will not be identical to M3, only the mapping and chroma
      // limits wil be, hue will come from the key colors.
      secondaryKey:
          tones == FlexTones.material(brightness) ? null : secondarySeedColor,
      tertiaryKey:
          tones == FlexTones.material(brightness) ? null : tertiarySeedColor,
      // Tone chroma config and tone mapping is optional, if you do not add it
      // you get the config matching Flutter's Material 3 ColorScheme.fromSeed.
      tones: tones,
    );

// Make a high contrast light ColorScheme from the seeds.
//
// Used as fixed example of accessibility choice, it can be selected in this
// demo also via popup when accessible theme is not selected in host.
final ColorScheme schemeLightHc = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  primaryKey: primarySeedColor,
  secondaryKey: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
  tones: FlexTones.ultraContrast(Brightness.light),
);

// Make a ultra contrast dark ColorScheme from the seeds.
//
// Used as fixed example of accessibility choice, it can be selected in this
// demo also via popup when accessible theme is not selected in host.
final ColorScheme schemeDarkHc = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: primarySeedColor,
  secondaryKey: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
  tones: FlexTones.ultraContrast(Brightness.dark),
);

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

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SeedColorScheme.fromSeeds Demo',
      themeMode: themeMode,
      // Make light and dark theme using seeded color color schemes, where
      // seeding type is selected via a function.
      theme: ThemeData.from(
        colorScheme: selectedSeedScheme(
          Brightness.light,
          usedTone.tones(Brightness.light),
        ),
        useMaterial3: useMaterial3,
      ),
      darkTheme: ThemeData.from(
        colorScheme: selectedSeedScheme(
          Brightness.dark,
          usedTone.tones(Brightness.dark),
        ),
        useMaterial3: useMaterial3,
      ),
      // Define accessibility high contrast versions using same color base.
      // These are same as selecting the ultra contrast option in the popup.
      // By providing the choice on these themes, it will be auto selected
      // when platform accessibility theme is used.
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
          title: const Text('SeedColorScheme.fromSeeds Demo'),
          actions: <Widget>[
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
              child: ShowColorSchemeColors(),
            ),
            const SizedBox(height: 16),
            const Text(
              'You have pushed the button this many times:',
              textAlign: TextAlign.center,
            ),
            Text(
              '$counter',
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
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
