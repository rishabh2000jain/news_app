import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper/src/app/bloc/home/home_bloc.dart';
import 'package:paper/src/app/bloc/home/home_state.dart';
import 'package:paper/src/app/bloc/theme/theme_bloc.dart';
import 'package:paper/src/app/bloc/theme/theme_state.dart';
import 'package:paper/src/navigation/routes.dart';
import 'package:paper/src/resources/style/themes.dart';
import 'package:paper/src/shared_preference/app_preference.dart';

void main() async {
  /// [WidgetsFlutterBinding.ensureInitialized()] makes sure that we have an instance of the WidgetsBinding,
  /// which is required to use platform channels to call the native code.
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => HomeBloc(const InitialSearchState())),
      BlocProvider(
          create: (context) => ThemeBloc(AppPreferences.getThemeDetail())),
    ], child: MaterialAppWidget());
  }
}

class MaterialAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.getLightTheme(),
        darkTheme: AppThemes.getDarkTheme(),
        initialRoute: Routes.kHomeScreen,
        routes: Routes.routes,
        themeMode: state.theme,
      );
    });
  }
}
