import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper/src/app/bloc/news_search/home/home_bloc.dart';
import 'package:paper/src/app/bloc/search/news_search_bloc.dart';
import 'package:paper/src/app/bloc/theme/theme_bloc.dart';
import 'package:paper/src/app/bloc/theme/theme_state.dart';
import 'package:paper/src/navigation/routes.dart';
import 'package:paper/src/resources/values/app_colors.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => HomeBloc()),
      BlocProvider(create: (context) => NewsSearchBloc()),
      BlocProvider(create: (context) => ThemeBloc()),
    ], child: MaterialAppWidget());
  }
}

class MaterialAppWidget extends StatefulWidget {
  const MaterialAppWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MaterialAppWidget> createState() => _MaterialAppWidgetState();
}

class _MaterialAppWidgetState extends State<MaterialAppWidget> {
  late ThemeBloc _themeBloc;

  @override
  void initState() {
    _themeBloc = BlocProvider.of<ThemeBloc>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
        bloc: _themeBloc,
        builder: (BuildContext context, ThemeState state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColor.whiteColor,
              colorScheme: const ColorScheme.light(
                  background: AppColor.dullWhite,
                  primary: AppColor.whiteColor,
                  primaryVariant: AppColor.blackVariant,
                  secondary: AppColor.blackVariant,
                  secondaryVariant: AppColor.blackLight),
            ),
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: AppColor.blackVariant,
              colorScheme: const ColorScheme.dark(
                primary: AppColor.blackLight,
                primaryVariant: AppColor.whiteColor,
                background: AppColor.blackVariant,
                secondary: AppColor.grey,
                secondaryVariant: AppColor.whiteColor,
              ),
            ),
            initialRoute: Routes.kHomeScreen,
            routes: Routes.routes,
            themeMode: state.theme,
          );
        });
  }
}
