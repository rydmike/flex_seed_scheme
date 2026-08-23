import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flex_seed_scheme_example/theme/controllers/theme_controller.dart';
import 'package:material_ui/material_ui.dart';

class SelectPaletteType extends StatelessWidget {
  const SelectPaletteType({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<FlexPaletteType>(
      showSelectedIcon: false,
      // multiSelectionEnabled: false,
      segments: const <ButtonSegment<FlexPaletteType>>[
        ButtonSegment<FlexPaletteType>(
          value: FlexPaletteType.common,
          label: Text('Common'),
        ),
        ButtonSegment<FlexPaletteType>(
          value: FlexPaletteType.extended,
          label: Text('Extended'),
        )
      ],
      selected: <FlexPaletteType>{controller.paletteType},
      onSelectionChanged: (Set<FlexPaletteType> selected) {
        controller.setPaletteType(selected.first);
      },
    );
  }
}
