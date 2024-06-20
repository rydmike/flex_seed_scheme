import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/flex_color_extension.dart';
import '../../../core/views/universal/color_scheme_box.dart';
import '../../../core/views/universal/list_tile_reveal.dart';

/// Widget used to select used [FlexTones] with a popup menu.
///
/// Uses enhanced enum [FlexSchemeVariant] to get data for the UI.
class FlexTonesPopupMenu extends StatelessWidget {
  const FlexTonesPopupMenu({
    super.key,
    required this.variant,
    this.onChanged,
    this.title = '',
    this.contentPadding,
  });
  final FlexSchemeVariant variant;
  final ValueChanged<FlexSchemeVariant>? onChanged;
  final String title;
  final EdgeInsetsGeometry? contentPadding; // Defaults to 16.

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextStyle txtStyle = theme.textTheme.labelLarge!;

    return PopupMenuButton<FlexSchemeVariant>(
      tooltip: '',
      padding: EdgeInsets.zero,
      onSelected: (FlexSchemeVariant variant) {
        onChanged?.call(variant);
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<FlexSchemeVariant>>[
        for (final FlexSchemeVariant variant in FlexSchemeVariant.values)
          PopupMenuItem<FlexSchemeVariant>(
            value: variant,
            child: ListTile(
              dense: true,
              leading: Badge(
                label: variant.isFlutterScheme
                    ? const Text('MCU', style: TextStyle(fontSize: 8))
                    : const Text('FSS', style: TextStyle(fontSize: 8)),
                child: ColorSchemeBox(
                  optionIcon: variant.icon,
                  color: colorScheme.primary.darken(variant.shade),
                ),
              ),
              title: Text(variant.variantName, style: txtStyle),
            ),
          )
      ],
      child: ListTileReveal(
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('$title ${variant.variantName}'),
            Text(
              variant.description,
              style: txtStyle,
            ),
          ],
        ),
        subtitle: ListTile(
          title: Text('${variant.variantName}'
              ' scheme variant configuration info:'),
          subtitle: Text('${variant.configDetails}\n'),
        ),
        trailing: Badge(
          label: variant.isFlutterScheme
              ? const Text('MCU', style: TextStyle(fontSize: 8))
              : const Text('FSS', style: TextStyle(fontSize: 8)),
          child: ColorSchemeBox(
            color: colorScheme.primary,
            optionIcon: variant.icon,
          ),
        ),
      ),
    );
  }
}
