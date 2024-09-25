import 'package:flutter/material.dart';

/// App static functions and constants used in the example applications.
///
/// In a real app you probably prefer putting these into different static
/// classes that serves your application's usage. For these examples I
/// put them all in the same class, except the colors that are in their
/// own class.
sealed class AppData {
  // Returns the title of the MaterialApp.
  //
  // Used to set title on pages to same one that is defined in each example
  // as its app name. Handy as we only need to update in one place, where it
  // belongs and no need to put it as a const somewhere and no need to pass it
  // around via a title prop either. Also used in the About box as app name.
  static String title(BuildContext context) =>
      (context as Element).findAncestorWidgetOfExactType<MaterialApp>()!.title;

  // When building new public web versions of the demos, make sure to
  // update this info before triggering GitHub actions CI/CD that builds them.
  //
  // The name of the package this app demonstrates.
  static const String packageName = 'FlexSeed\u{00AD}Scheme';
  // Version of the WEB build, usually same as package, but it also has a
  // build numbers.
  static const String versionMajor = '3';
  static const String versionMinor = '4';
  static const String versionPatch = '1';
  static const String versionBuild = '01';
  static const String version = '$versionMajor.$versionMinor.$versionPatch '
      'Build-$versionBuild';
  static const String packageVersion =
      '$versionMajor.$versionMinor.$versionPatch';
  static const String flutterVersion = '3.24.3 (canvaskit)';
  static const String copyright = '© 2022-2024';
  static const String author = 'Mike Rydstrom';
  static const String license = 'BSD 3-Clause License';
  static final Uri packageUri = Uri(
    scheme: 'https',
    host: 'pub.dev',
    path: 'packages/flex_seed_scheme',
  );

  // The minimum media width treated as a phone device in this demo.
  static const double phoneWidthBreakpoint = 600;
  // The minimum media height treated as a phone device in this demo.
  static const double phoneHeightBreakpoint = 700;
}
