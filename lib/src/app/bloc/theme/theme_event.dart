import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class AppThemeModel extends ThemeEvent {
  final ThemeMode theme;
  const AppThemeModel({required this.theme});
  @override
  List<Object?> get props => throw UnimplementedError();
}


