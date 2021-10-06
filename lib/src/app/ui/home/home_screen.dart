import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper/src/app/bloc/home/home_bloc.dart';
import 'package:paper/src/app/bloc/home/home_event.dart';
import 'package:paper/src/app/bloc/home/home_state.dart';
import 'package:paper/src/app/bloc/theme/theme_bloc.dart';
import 'package:paper/src/app/bloc/theme/theme_event.dart';
import 'package:paper/src/app/bloc/theme/theme_state.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/app/repository/news/api/models/news_response.dart';
import 'package:paper/src/app/ui/home/widgets/country_grid.dart';
import 'package:paper/src/app/ui/home/widgets/news_category_chips.dart';
import 'package:paper/src/app/ui/home/widgets/top_headlines_list.dart';
import 'package:paper/src/constants/app_constants.dart';
import 'package:paper/src/navigation/app_router.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/shared_preference/app_preference.dart';
import 'package:paper/src/utils/themes_enum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //holds the article list
  late List<Article> _articlesList = [];
  late ThemeBloc _themeBloc;

  ///holds the instance of [HomeBloc]
  late HomeBloc _homeBloc;

  ///For listening the scroll in [ListView]
  late final ScrollController _controller;

  ///this variable is for pagination in application it is used loads next page if available
  int _page = 1;

  ///keep track of next page availability
  bool _isNextPage = true;

  String _category = 'general';

  //used for selection of country
  String? _countryName;
  int _countryPos = 23;

  @override
  void initState() {
    //bloc provider tor api call initialize
    //listen is false because we don't want to build all widgets.
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    //listener attached to controller
    _themeBloc = BlocProvider.of<ThemeBloc>(context, listen: false);
    _homeBloc = BlocProvider.of<HomeBloc>(context, listen: false);

    _countryPos = AppPreferences.getCountry();
    _countryName = AppConstants.kCountry[_countryPos];
    super.initState();
  }

  ///clears list and assign page to 1
  void _resetApiParam() {
    _isNextPage = true;
    _page = 1;
    _articlesList.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        _isNextPage &&
        _homeBloc.state is! LoadingSearchState) {
      _makeApiCall();
    }
  }

//method to add search event to bloc
  void _makeApiCall() {
    _homeBloc.add(
        HomeModule(page: _page, category: _category, country: _countryName));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppStrings.kAppNameString, style: theme.textTheme.headline5),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.moveToNewsSearchScreen(context);
              },
              icon: const Icon(
                Icons.search,
              )),
          //it is used to select country
          IconButton(
            icon: const Icon(Icons.flag),
            onPressed: () async {
              await showModalBottomSheet<int>(
                context: context,
                isDismissible: true,
                builder: (context) {
                  return const CountryListWidget();
                },
              ).then(
                (value) {
                  if (value != null && value != _countryPos) {
                    _countryPos = value;
                    _countryName = AppConstants.kCountry[_countryPos];
                    _resetApiParam();
                    _makeApiCall();
                  }
                },
              );
            },
          ),
          //for theme selection
          PopupMenuButton(
            icon: const Icon(
              Icons.wb_sunny,
              size: 30,
            ),
            onSelected: (AppThemeOption theme) {
              switch (theme) {
                case AppThemeOption.LIGHT:
                  _themeBloc.add(const AppThemeModel(theme: ThemeMode.light));
                  break;
                case AppThemeOption.DARK:
                  _themeBloc.add(const AppThemeModel(theme: ThemeMode.dark));
                  break;
                case AppThemeOption.SYSTEM:
                  _themeBloc.add(const AppThemeModel(theme: ThemeMode.system));
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              ThemeState state = AppPreferences.getThemeDetail();
              return [
                PopupMenuItem(
                  enabled: !(state.theme == ThemeMode.light),
                  child: const Text('Light Theme'),
                  value: AppThemeOption.LIGHT,
                ),
                PopupMenuItem(
                  child: const Text('Dark Theme'),
                  enabled: !(state.theme == ThemeMode.dark),
                  value: AppThemeOption.DARK,
                ),
                PopupMenuItem(
                    enabled: !(state.theme == ThemeMode.system),
                    child: const Text('System Theme'),
                    value: AppThemeOption.SYSTEM),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 10),
              child: Text(
                AppStrings.kCategoryString,
                style: theme.textTheme.bodyText2,
                textAlign: TextAlign.left,
              ),
            ),
            //CategoryChipList is a list of chips so that user can select category
            CategoryChipList(
              colorScheme: theme.colorScheme,
              categorySelected: (category) {
                _isNextPage = true;
                _page = 1;
                _category = category;
                _articlesList.clear();
                _makeApiCall();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 10, top: 10),
              child: Text(
                AppStrings.kTopHeadlinesString,
                style: theme.textTheme.bodyText2,
                textAlign: TextAlign.left,
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              bloc: _homeBloc,
              builder: (context, homeState) {
                if (homeState is InitialSearchState) {
                  _makeApiCall();
                  return Container();
                } else if (homeState is LoadedSearchState) {
                  NewsResponse? response = homeState.searchResponse.data;
                  _articlesList += response!.articles!;
                  if (response.totalResults! > _articlesList.length) {
                    _page += 1;
                    _isNextPage = true;
                  } else {
                    _isNextPage = false;
                  }
                  return Expanded(
                      child: TopHeadlinesList(
                    controller: _controller,
                    articlesList: _articlesList,
                    hasNextPage: _isNextPage,
                  ));
                } else if (homeState is LoadingSearchState) {
                  return _articlesList.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: TopHeadlinesList(
                          controller: _controller,
                          articlesList: _articlesList,
                          hasNextPage: _isNextPage,
                        ));
                } else if (homeState is SearchApiErrorState ||
                    homeState is SearchErrorState) {
                  _resetApiParam();
                  return Column(children: [
                    Image.asset(
                      AppStrings.kPageNotFoundImage,
                      fit: BoxFit.fill,
                    ),
                    TextButton(
                      onPressed: () {
                        _makeApiCall();
                      },
                      child: const Text(
                        'Refresh',
                      ),
                    )
                  ]);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
