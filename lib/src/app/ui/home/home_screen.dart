import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper/src/app/bloc/news_search/home/home_bloc.dart';
import 'package:paper/src/app/bloc/news_search/home/home_event.dart';
import 'package:paper/src/app/bloc/news_search/home/home_state.dart';
import 'package:paper/src/app/bloc/theme/theme_bloc.dart';
import 'package:paper/src/app/bloc/theme/theme_event.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/app/repository/news/api/models/news_response.dart';
import 'package:paper/src/app/ui/home/widgets/news_category_chips.dart';
import 'package:paper/src/app/ui/home/widgets/top_headlines_list.dart';
import 'package:paper/src/navigation/app_router.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/utils/screen_enum.dart';
import 'package:paper/src/utils/themes.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //holds the article list
  late List<Articles> _articlesList = [];
  late ThemeBloc _themeBloc;

  ///holds the instance of [HomeBloc]
  late HomeBloc _homeBloc;

  ///For listening the scroll in [ListView]
  late final ScrollController _controller;

  int _page = 1;

  bool _isNextPage = true;

  String _category = 'general';

  String _country = 'in';

  @override
  void initState() {
    //bloc provider tor api call initialize
    //listen is false because we don't want to build all widgets.
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    //listener attached to controller
    _themeBloc = BlocProvider.of<ThemeBloc>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _homeBloc = BlocProvider.of<HomeBloc>(context, listen: false);
    super.didChangeDependencies();
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
    _homeBloc
        .add(HomeModule(page: _page, category: _category, country: _country));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.APP_NAME_STRING,
          style: TextStyle(
              color: colorScheme.primaryVariant,
              fontWeight: FontWeight.w900,
              fontSize: 23,
              fontFamily: AppStrings.PLAYFAIR_DISPLAY_FONT),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.moveToNewsSearchScreen(context);
              },
              icon: Icon(
                Icons.search,
                color: colorScheme.primaryVariant,
                size: 30,
              )),
          PopupMenuButton(
            icon: Icon(
              Icons.wb_sunny,
              color: colorScheme.primaryVariant,
            ),
            onSelected: (AppThemes theme) {
              switch (theme) {
                case AppThemes.LIGHT:
                  _themeBloc.add(const AppThemeModel(theme: ThemeMode.light));
                  break;
                case AppThemes.DARK:
                  _themeBloc.add(const AppThemeModel(theme: ThemeMode.dark));
                  break;
                case AppThemes.SYSTEM:
                  _themeBloc.add(const AppThemeModel(theme: ThemeMode.system));
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Text('Light Theme'),
                  value: AppThemes.LIGHT,
                ),
                const PopupMenuItem(
                  child: Text('Dark Theme'),
                  value: AppThemes.DARK,
                ),
                const PopupMenuItem(
                    child: Text('System Theme'), value: AppThemes.SYSTEM),
              ];
            },
          )
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
                AppStrings.CATEGORY_STRING,
                style: TextStyle(
                    color: colorScheme.primaryVariant,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            //CategoryChipList is a list of chips so that user can select category
            CategoryChipList(
              colorScheme: colorScheme,
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
                AppStrings.TOP_HEADLINE_STRING,
                style: TextStyle(
                  color: colorScheme.primaryVariant,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              bloc: _homeBloc,
              builder: (context, homeState) {
                if (homeState.screens != Screens.HOME) return Container();
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
                      ? Center(
                          child: CircularProgressIndicator(
                            color: colorScheme.primaryVariant,
                          ),
                        )
                      : Expanded(
                          child: TopHeadlinesList(
                          controller: _controller,
                          articlesList: _articlesList,
                          hasNextPage: _isNextPage,
                        ));
                }
                else if (homeState is SearchApiErrorState) {
                  return Center(
                    child: Image.asset(
                      AppStrings.PageNotFoundImage,
                      fit: BoxFit.fitWidth,
                    ),
                  );
                }
                else if (homeState is SearchErrorState) {
                  return Center(
                    child: Image.asset(
                      AppStrings.PageNotFoundImage,
                      fit: BoxFit.fitWidth,
                    ),
                  );
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
