// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Set of themes supported by Dynamic Color.
/// Instantiate the corresponding subclass, ex. SchemeTonalSpot, to create
/// colors corresponding to the theme.
enum Variant {
  /// All colors are grayscale, no chroma.
  monochrome('monochrome', 'All colors are grayscale, no chroma.'),

  /// Close to grayscale, a hint of chroma.
  neutral('neutral', 'Close to grayscale, a hint of chroma.'),

  /// Pastel tokens, low chroma palettes.
  tonalSpot(
      'tonal spot',
      'Pastel tokens, low chroma palettes (32).\n'
          'Default Material You theme at 2021 launch.'),

  /// Pastel colors, high chroma palettes.
  vibrant(
      'vibrant',
      'Pastel colors, high chroma palettes. (max).\n'
          "The primary palette's chroma is at maximum.\n"
          'Use Fidelity instead if tokens should alter their '
          'tone to match the palette vibrancy.'),

  /// Pastel colors, medium chroma palettes.
  expressive(
      'expressive',
      'Pastel colors, medium chroma palettes.\n'
          "The primary palette's hue is different from source color, "
          'for variety.'),

  /// Almost identical to Fidelity.
  content(
      'content',
      'Almost identical to Fidelity.\n'
          'Tokens and palettes match source color.\n'
          'Primary Container is source color, adjusted to ensure contrast '
          'with surfaces.\n\n'
          'Tertiary palette is analogue of source color.\nFound by dividing '
          'color wheel by 6, then finding the 2 colors adjacent to source.\n'
          'The one that increases hue is used.'),

  /// Tokens and palettes match source color.
  fidelity(
      'fidelity',
      'Tokens and palettes match source color.\n'
          'Primary Container is source color, adjusted to ensure contrast '
          'with surfaces.\n'
          'For example, if source color is black, it is lightened so it '
          "doesn't match surfaces in dark mode.\n\n"
          'Tertiary palette is complement of source color.'),

  /// A playful theme - the source color's hue does not appear in the theme.
  rainbow('rainbow',
      "A playful theme - the source color's hue does not appear in the theme."),

  /// A playful theme - the source color's hue does not appear in the theme.
  fruitSalad('fruit salad',
      "A playful theme - the source color's hue does not appear in the theme.");

  /// Enum constructor
  const Variant(this.label, this.description);

  /// The label of the variant color scheme.
  final String label;

  /// A description of the variant color scheme.
  final String description;
}
