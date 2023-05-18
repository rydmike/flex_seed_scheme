import 'package:flutter/material.dart';

import '../model/flex_tones_enum.dart';

/// A ChangeNotifier controller used to control input that configures
/// ThemeData and ThemeMode.
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

  bool _keepAllOnColorsBW = false;
  bool get keepAllOnColorsBW => _keepAllOnColorsBW;
  void setKeepAllOnColorsBW(bool? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _keepAllOnColorsBW) return;
    _keepAllOnColorsBW = value;
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

  Color _primarySeedColor = const Color(0xFF6750A4);
  Color get primarySeedColor => _primarySeedColor;
  void setPrimarySeedColor(Color? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _primarySeedColor) return;
    _primarySeedColor = value;
    if (notify) notifyListeners();
  }

  Color _secondarySeedColor = const Color(0xFF3871BB);
  Color get secondarySeedColor => _secondarySeedColor;
  void setSecondarySeedColor(Color? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _secondarySeedColor) return;
    _secondarySeedColor = value;
    if (notify) notifyListeners();
  }

  Color _tertiarySeedColor = const Color(0xFF6CA450);
  Color get tertiarySeedColor => _tertiarySeedColor;
  void setTertiarySeedColor(Color? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _tertiarySeedColor) return;
    _tertiarySeedColor = value;
    if (notify) notifyListeners();
  }
}
