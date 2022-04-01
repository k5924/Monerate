import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// This is the light theme mode configuration for the application
ThemeData kLightTheme = FlexColorScheme.light(
  scheme: FlexScheme.deepPurple,
).toTheme;

/// This is the dark theme mode configuration for the application
ThemeData kDarkTheme = FlexColorScheme.dark(
  scheme: FlexScheme.deepPurple,
).toTheme;
