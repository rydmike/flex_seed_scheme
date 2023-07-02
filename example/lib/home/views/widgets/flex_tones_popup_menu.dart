import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/flex_color_extension.dart';
import '../../../core/views/universal/color_scheme_box.dart';
import '../../../theme/model/flex_tones_enum.dart';

/// Widget used to select used [FlexTones] with a popup menu.
///
/// Uses enhanced enum [FlexTonesEnum] to get data for the UI.
class FlexTonesPopupMenu extends StatelessWidget {
  const FlexTonesPopupMenu({
    super.key,
    required this.tone,
    this.onChanged,
    this.title = '',
    this.contentPadding,
  });
  final FlexTonesEnum tone;
  final ValueChanged<FlexTonesEnum>? onChanged;
  final String title;
  final EdgeInsetsGeometry? contentPadding; // Defaults to 16.

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextStyle txtStyle = theme.textTheme.labelLarge!;

    return PopupMenuButton<FlexTonesEnum>(
      tooltip: '',
      padding: EdgeInsets.zero,
      onSelected: (FlexTonesEnum tone) {
        onChanged?.call(tone);
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<FlexTonesEnum>>[
        for (FlexTonesEnum tone in FlexTonesEnum.values)
          PopupMenuItem<FlexTonesEnum>(
            value: tone,
            child: ListTile(
              dense: true,
              leading: ColorSchemeBox(
                optionIcon: tone.icon,
                color: colorScheme.primary.darken(tone.shade),
              ),
              title: Text(tone.toneLabel, style: txtStyle),
            ),
          )
      ],
      child: ListTile(
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
        title: Text('$title ${tone.toneLabel}'),
        subtitle: Text(tone.describe),
        trailing: ColorSchemeBox(
          color: colorScheme.primary,
          optionIcon: tone.icon,
        ),
      ),
    );
  }
}
