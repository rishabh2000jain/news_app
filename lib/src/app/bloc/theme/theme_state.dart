import 'package:flutter/material.dart';

abstract class ThemeState {
  const ThemeState(this.theme);
  final theme;
}

class LightThemeState extends ThemeState {
  const LightThemeState() : super(ThemeMode.light);
  @override
  List<Object> get props => [];
}

class DarkThemeState extends ThemeState {
  const DarkThemeState():super(ThemeMode.dark);

  @override
  List<Object> get props => [];
}

class SystemThemeState extends ThemeState {
  const SystemThemeState():super(ThemeMode.system);
  @override
  List<Object> get props => [];
}
