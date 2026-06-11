import 'dart:io';


/// Your color names from AppColors
const List<String> colors = [
  'white',
  'black',
  'grey',
  'orange',
  'lightGrey',
  'secoundry',
  'primary',
];

/// Font weights to generate
const Map<int, String> weights = {
  100: 'w100',
  200: 'w200',
  300: 'w300',
  400: 'w400',
  500: 'w500',
  600: 'w600',
  700: 'w700',
  800: 'w800',
  900: 'w900',
};

/// Sizes to generate
final List<int> sizes = [for (int i = 8; i <= 50; i++) i];

void main() {
  final buffer = StringBuffer();

  // Write imports directly into generated file
  buffer.writeln("import 'package:flutter/material.dart';");
  buffer
      .writeln("import 'package:flutter_screenutil/flutter_screenutil.dart';");
  buffer
      .writeln("import 'package:lasco/core/constants/app_colors.dart';\n");

  buffer.writeln('abstract class CustomTextStyle {');
  buffer.writeln('  static const String fontFamily = "Beiruti";\n');
  buffer.writeln(
      '  static TextStyle _style({required double size, required FontWeight weight, required Color color}) {');
  buffer.writeln('    return TextStyle(');
  buffer.writeln('      fontFamily: fontFamily,');
  buffer.writeln('      fontWeight: weight,');
  buffer.writeln('      fontSize: size.sp,');
  buffer.writeln('      color: color,');
  buffer.writeln('      overflow: TextOverflow.ellipsis,');
  buffer.writeln('    );');
  buffer.writeln('  }\n');

  // Generate constants
  for (final weightValue in weights.keys) {
    for (final size in sizes) {
      for (final color in colors) {
        final constantName =
            'font${weightValue}sized$size${_capitalize(color)}';
        buffer.writeln(
            '  static final $constantName = _style(size: $size, weight: FontWeight.${weights[weightValue]}, color: AppColors.$color,);');
      }
    }
  }

  buffer.writeln('}');

  // Save file
  File('lib/core/constants/custom_text_style.dart')
      .writeAsStringSync(buffer.toString());

  print(
      "✅ Generated lib/core/constants/custom_text_style.dart with ${weights.length * sizes.length * colors.length} styles");
}

String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
