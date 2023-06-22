import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../model/flex_tones_enum.dart';

/// A ChangeNotifier controller used to control inputs that configures the
/// ColorScheme in ThemeData and ThemeMode.
class ThemeController with ChangeNotifier {
  ThemeController();

  bool _useMaterial3 = true;
  bool get useMaterial3 => _useMaterial3;
  void setUseMaterial3(bool? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _useMaterial3) return;
    _useMaterial3 = value;
    if (notify) notifyListeners();
  }

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  void setThemeMode(ThemeMode? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _themeMode) return;
    _themeMode = value;
    if (notify) notifyListeners();
  }

  bool _useSecondaryKey = false;
  bool get useSecondaryKey => _useSecondaryKey;
  void setUseSecondaryKey(bool? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _useSecondaryKey) return;
    _useSecondaryKey = value;
    if (notify) notifyListeners();
  }

  bool _useTertiaryKey = false;
  bool get useTertiaryKey => _useTertiaryKey;
  void setUseTertiaryKey(bool? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _useTertiaryKey) return;
    _useTertiaryKey = value;
    if (notify) notifyListeners();
  }

  bool _keepMainOnColorsBW = false;
  bool get keepMainOnColorsBW => _keepMainOnColorsBW;
  void setKeepMainOnColorsBW(bool? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _keepMainOnColorsBW) return;
    _keepMainOnColorsBW = value;
    if (notify) notifyListeners();
  }

  bool _keepSurfaceOnColorsBW = false;
  bool get keepSurfaceOnColorsBW => _keepSurfaceOnColorsBW;
  void setKeepSurfaceOnColorsBW(bool? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _keepSurfaceOnColorsBW) return;
    _keepSurfaceOnColorsBW = value;
    if (notify) notifyListeners();
  }

  FlexTonesEnum _usedTone = FlexTonesEnum.custom;
  FlexTonesEnum get usedTone => _usedTone;
  void setUsedTone(FlexTonesEnum? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _usedTone) return;
    _usedTone = value;
    if (notify) notifyListeners();
  }

  Color _primarySeedColor = AppColor.primary;
  Color get primarySeedColor => _primarySeedColor;
  void setPrimarySeedColor(Color? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _primarySeedColor) return;
    _primarySeedColor = value;
    if (notify) notifyListeners();
  }

  Color _secondarySeedColor = AppColor.secondary;
  Color get secondarySeedColor => _secondarySeedColor;
  void setSecondarySeedColor(Color? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _secondarySeedColor) return;
    _secondarySeedColor = value;
    if (notify) notifyListeners();
  }

  Color _tertiarySeedColor = AppColor.tertiary;
  Color get tertiarySeedColor => _tertiarySeedColor;
  void setTertiarySeedColor(Color? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _tertiarySeedColor) return;
    _tertiarySeedColor = value;
    if (notify) notifyListeners();
  }
}
