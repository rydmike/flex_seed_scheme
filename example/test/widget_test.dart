import 'package:flex_seed_scheme_example/main.dart';
import 'package:flex_seed_scheme_example/theme/controllers/theme_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Create a ThemeController.
    final ThemeController controller = ThemeController();
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(controller: controller));
  });
}
