import 'package:flutter/material.dart';

/// Widget used to display a colored option box used in PopupMenus.
class ColorSchemeBox extends StatelessWidget {
  const ColorSchemeBox({
    super.key,
    this.color = Colors.white,
    this.size = const Size(45, 35),
    this.optionIcon = Icons.texture_outlined,
  });

  final Color color;
  final Size size;
  final IconData optionIcon;

  // Return true if the color is light, meaning it needs dark text for contrast.
  static bool _isLight(final Color color) =>
      ThemeData.estimateBrightnessForColor(color) == Brightness.light;

  // On color for icon on the colored box.
  static Color _onColor(final Color color) => _isLight(color)
      ? Colors.black.withOpacity(0.4)
      : Colors.white.withOpacity(0.4);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Material(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        child: Icon(optionIcon, color: _onColor(color)),
      ),
    );
  }
}
