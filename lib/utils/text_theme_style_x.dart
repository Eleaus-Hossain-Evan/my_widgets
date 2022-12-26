import 'package:flutter/material.dart';

extension TextThemeStylesX on BuildContext {
  TextStyle get bodyText1 => Theme.of(this).textTheme.bodyText1!;

  TextStyle get bodyText2 => Theme.of(this).textTheme.bodyText2!;

  TextStyle get subtitle1 => Theme.of(this).textTheme.subtitle1!;

  TextStyle get subtitle2 => Theme.of(this).textTheme.subtitle2!;

  TextStyle get headline1 => Theme.of(this).textTheme.headline1!;

  TextStyle get headline2 => Theme.of(this).textTheme.headline2!;

  TextStyle get headline3 => Theme.of(this).textTheme.headline3!;

  TextStyle get headline4 => Theme.of(this).textTheme.headline4!;

  TextStyle get headline5 => Theme.of(this).textTheme.headline5!;

  TextStyle get headline6 => Theme.of(this).textTheme.headline6!;

  TextStyle get headlineLarge => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
  TextStyle get caption =>
      Theme.of(this).textTheme.caption!.copyWith(fontWeight: FontWeight.w600);
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;
  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;
  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;
  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;
  TextStyle get labelLMedium => Theme.of(this).textTheme.labelMedium!;
  TextStyle get labelLSmall => Theme.of(this).textTheme.labelSmall!;
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;

  ColorScheme get color => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);
}
