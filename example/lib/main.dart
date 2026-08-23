import 'package:flex_seed_scheme_example/home/views/pages/home_page.dart';
import 'package:flex_seed_scheme_example/theme/controllers/theme_controller.dart';
import 'package:flex_seed_scheme_example/theme/model/app_theme.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  // Create a ThemeController.
  final ThemeController controller = ThemeController();
  runApp(MyApp(controller: controller));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SeedColorScheme.fromSeeds',
          themeMode: controller.themeMode,
          theme: AppTheme.light(controller),
          darkTheme: AppTheme.dark(controller),
          highContrastTheme: AppTheme.highContrastLight(controller),
          highContrastDarkTheme: AppTheme.highContrastDark(controller),
          builder: (BuildContext context, Widget? child) {
            // ignore: deprecated_member_use, temporary fix for MaterialUi compatibility.
            return MaterialUiCompatibilityBridge(child: child!);
          },
          home: HomePage(controller: controller),
        );
      },
    );
  }
}
