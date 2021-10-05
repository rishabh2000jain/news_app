import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper/src/app/bloc/home/home_state.dart';
import 'package:paper/src/app/bloc/search/news_search_bloc.dart';
import 'package:paper/src/app/bloc/search/search_event.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/app/ui/search/widgets/search_news_list.dart';
import 'package:paper/src/app/ui/search/widgets/search_view.dart';
import 'package:paper/src/constants/app_constants.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/utils/app_util.dart';
import 'package:paper/src/utils/screen_enum.dart';

class NewsSearchScreen extends StatefulWidget {
  const NewsSearchScreen({Key? key}) : super(key: key);

  @override
  State<NewsSearchScreen> createState() => _NewsSearchScreenState();
}

class _NewsSearchScreenState extends State<NewsSearchScreen> {
  final List<Article> _articles = [];
  late NewsSearchBloc _newsSearchBloc;
  int _currentPage = 1;
  late ScrollController _controller;

  bool _isNextPage = true;

  String _query = '';

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_listenScroll);
    _newsSearchBloc = NewsSearchBloc(const InitialSearchState(Screens.SEARCH));
    super.initState();
  }

  void _makeApiCall(String query) {
    _query = query;
    _articles.clear();
    if (!AppUtil.isStringEmpty(query)) {
      _newsSearchBloc.add(SearchModule(page: _currentPage, query: query));
    }
  }

  void _listenScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        _isNextPage &&
        (_newsSearchBloc.state is! LoadingSearchState &&
            _newsSearchBloc.state.screens == Screens.SEARCH)) {
      _currentPage += 1;
      _newsSearchBloc.add(SearchModule(page: _currentPage, query: _query));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _articles.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppConstants.kSpacer_15,
            Center(
              child: SearchView(
                searchData: _makeApiCall,
                size: size,
              ),
            ),
            BlocBuilder<NewsSearchBloc, HomeState>(
              buildWhen: (context, state) {
                return state.screens == Screens.SEARCH;
              },
              bloc: _newsSearchBloc,
              builder: (context, state) {
                if (state is InitialSearchState) {
                  return Container();
                } else if (state is LoadedSearchState) {
                  final data = state.searchResponse.data!;
                  _articles.addAll(data.articles!);
                  if (data.totalResults! > _articles.length) {
                    _isNextPage = true;
                  } else {
                    _isNextPage = false;
                  }
                  return SearchList(
                      controller: _controller,
                      articles: _articles,
                      hasNext: _isNextPage,
                      theme: theme);
                } else if (state is LoadingSearchState) {
                  return _articles.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SearchList(
                          controller: _controller,
                          articles: _articles,
                          theme: theme,
                          hasNext: _isNextPage,
                        );
                } else if (state is SearchApiErrorState ||
                    state is SearchErrorState) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Image.asset(
                        AppStrings.PageNotFoundImage,
                        fit: BoxFit.fitWidth,
                      ),
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
