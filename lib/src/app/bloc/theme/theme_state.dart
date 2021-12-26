import 'package:flutter/material.dart';

abstract class ThemeState {
  const ThemeState(this.theme);
  final ThemeMode theme;
}

class LightThemeState extends ThemeState {
  const LightThemeState() : super(ThemeMode.light);

  List<Object> get props => [];
}

class DarkThemeState extends ThemeState {
  const DarkThemeState():super(ThemeMode.dark);

  List<Object> get props => [];
}

class SystemThemeState extends ThemeState {
  const SystemThemeState():super(ThemeMode.system);

  List<Object> get props => [];
}
