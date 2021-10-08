import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper/src/app/bloc/theme/theme_event.dart';
import 'package:paper/src/app/bloc/theme/theme_state.dart';
import 'package:paper/src/shared_preference/app_preference.dart';
import 'package:paper/src/utils/themes_enum.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  ThemeBloc(ThemeState initialState) : super(initialState);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is AppThemeModel) {
      switch (event.theme) {
        case ThemeMode.light:
         await AppPreferences.setThemeDetail(AppThemeOption.LIGHT);
          yield const LightThemeState();
          break;
        case ThemeMode.system:
          await AppPreferences.setThemeDetail(AppThemeOption.SYSTEM);
          yield const SystemThemeState();
          break;
        case ThemeMode.dark:
          await AppPreferences.setThemeDetail(AppThemeOption.DARK);
          yield const DarkThemeState();
          break;
      }
    }
  }
}
