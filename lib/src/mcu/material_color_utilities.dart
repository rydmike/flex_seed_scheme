// Copyright 2021 Google LLC
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

// RydMike: This contains a local copy of Material Color Utilities used by
// FlexSeedScheme.
//
// Since MCU is using zero semver and Flutter SDK, depends on it, any
// minor version number change is breaking and cannot be resolved across
// Flutter channels if a package also uses MCU. This is the reason why (FSS)
// for now does not use MCU directly. It bundles its own version of it for now.
// This also means FSS may sometimes use a newer version of MCU than Flutter
// stable, beta, and master. FSS may stop bundling MCU when it stops getting
// so many frequent breaking updates that cause dependency mess for a package
// that needs to depend on MCU and work on all Flutter channels.
export 'blend/blend.dart';
export 'contrast/contrast.dart';
export 'dislike/dislike_analyzer.dart';
export 'dynamiccolor/dynamic_color.dart';
export 'dynamiccolor/dynamic_scheme.dart';
export 'dynamiccolor/material_dynamic_colors.dart';
export 'dynamiccolor/variant.dart';
export 'hct/cam16.dart';
export 'hct/hct.dart';
export 'hct/viewing_conditions.dart';
export 'palettes/core_palette.dart';
export 'palettes/tonal_palette.dart';
export 'quantize/quantizer.dart';
export 'quantize/quantizer_celebi.dart';
export 'quantize/quantizer_map.dart';
export 'quantize/quantizer_wsmeans.dart';
export 'quantize/quantizer_wu.dart';
export 'scheme/scheme.dart';
export 'scheme/scheme_content.dart';
export 'scheme/scheme_expressive.dart';
export 'scheme/scheme_fidelity.dart';
export 'scheme/scheme_fruit_salad.dart';
export 'scheme/scheme_monochrome.dart';
export 'scheme/scheme_neutral.dart';
export 'scheme/scheme_rainbow.dart';
export 'scheme/scheme_tonal_spot.dart';
export 'scheme/scheme_vibrant.dart';
export 'score/score.dart';
export 'temperature/temperature_cache.dart';
export 'utils/color_utils.dart';
export 'utils/math_utils.dart';
export 'utils/string_utils.dart';
