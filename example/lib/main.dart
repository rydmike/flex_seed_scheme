import 'package:flutter/material.dart';

import 'home/views/pages/home_page.dart';
import 'theme/controllers/theme_controller.dart';
import 'theme/model/app_theme.dart';

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
          home: HomePage(controller: controller),
        );
      },
    );
  }
}
