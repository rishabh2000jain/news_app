import 'package:logging/logging.dart';
import 'package:paper/src/app/bloc/theme/theme_state.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/utils/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

///[AppPreferences] is a singleton class used for creating
/// the shared preference once in whole application lifecycle

class AppPreferences {
  ///variable _appPreferences is static so it will be instantiated automatically
  static Logger logger = Logger('AppPreferences');

  ///[SharedPreferences] is is used to store the theme state [AppThemes]
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
  instance = await SharedPreferences.getInstance();

 static  Future<SharedPreferences> getInstance() async{
    return  await SharedPreferences.getInstance();
  }

  ///return true or false only on the saving of the [AppThemes] data.
  static Future<bool> setThemeDetail(AppThemes appThemes) async {
    SharedPreferences instance = await getInstance();
    try {
      bool result =
          await instance.setInt(AppStrings.kThemeDataPref, appThemes.index);
      return result;
    } catch (e) {
      logger.log(Level.INFO, '${e.toString()} error from preferences');
    }
    return false;
  }

  ///return the theme state name form the SharedPreferences
  static Future<ThemeState> getThemeDetail() async {
    SharedPreferences instance = await getInstance();

    int? _result = AppThemes.DARK.index;
    try {
      _result = instance.getInt(AppStrings.kThemeDataPref);
    } catch (e) {
      logger.log(Level.INFO, e.toString());
    }
    print('form pref $_result');
    switch (AppThemes.values[_result!]) {
      case AppThemes.LIGHT:
        return const LightThemeState();
      case AppThemes.DARK:
        return const DarkThemeState();
      case AppThemes.SYSTEM:
        return const SystemThemeState();
    }
  }
}
