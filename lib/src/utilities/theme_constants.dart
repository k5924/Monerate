import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData kLightTheme = FlexColorScheme.light(
  scheme: FlexScheme.deepPurple,
).toTheme;

ThemeData kDarkTheme = FlexColorScheme.dark(
  scheme: FlexScheme.deepPurple,
).toTheme;
