import 'package:logging/logging.dart';
import 'package:paper/src/app/bloc/theme/theme_state.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/utils/themes_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

///[AppPreferences] is a singleton class used for creating
/// the shared preference once in whole application lifecycle

class AppPreferences {
  static final Logger _logger = Logger('AppPreferences');

  AppPreferences._create();

  static final Future<SharedPreferences> _pref =
      SharedPreferences.getInstance();
  static SharedPreferences? _instance;

  static Future<void> init() async {
    try {
      _instance = await _pref;
    } catch (e) {
      _logger.log(Level.INFO, e.toString());
    }
  }

  ///return true or false only on the saving of the [AppThemeOption] data.
  static Future<bool> setThemeDetail(AppThemeOption appThemes) async {
    try {
      bool result =
          await _instance?.setInt(AppStrings.kThemeDataPref, appThemes.index) ??
              false;
      return result;
    } catch (e) {
      _logger.log(Level.INFO, '${e.toString()} error from preferences');
    }
    return false;
  }

  ///return the theme state name form the SharedPreferences
  static ThemeState getThemeDetail() {
    int _result = 0;
    try {
      _result = _instance?.getInt(AppStrings.kThemeDataPref) ?? 0;
    } catch (e) {
      _logger.log(Level.INFO, 'getThemeDetail ${e.toString()}');
    }
    switch (AppThemeOption.values[_result]) {
      case AppThemeOption.tLight:
        return const LightThemeState();
      case AppThemeOption.tDark:
        return const DarkThemeState();
      case AppThemeOption.tSystem:
        return const SystemThemeState();
    }
  }

  static void setCountry(int country) async {
    await _instance?.setInt(AppStrings.kCountryPref, country);
  }

  static int getCountry() {
    return _instance?.getInt(AppStrings.kCountryPref) ?? 23;
  }
}
