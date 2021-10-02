import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper/src/app/bloc/theme/theme_event.dart';
import 'package:paper/src/app/bloc/theme/theme_state.dart';
import 'package:paper/src/shared_preference/app_preference.dart';
import 'package:paper/src/utils/themes.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  ThemeBloc() : super(const SystemThemeState());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {

    if (event is AppThemeModel) {
      switch (event.theme) {
        case ThemeMode.light:
          bool res = await AppPreferences.setThemeDetail(AppThemes.LIGHT);
          print(res);
          yield const LightThemeState();
          break;
        case ThemeMode.system:
          bool res = await AppPreferences.setThemeDetail(AppThemes.SYSTEM);
          print(res);

          yield const SystemThemeState();
          break;
        case ThemeMode.dark:
          bool res = await AppPreferences.setThemeDetail(AppThemes.DARK);
          print(res);
          yield const DarkThemeState();
          break;
      }
    }
  }
}
