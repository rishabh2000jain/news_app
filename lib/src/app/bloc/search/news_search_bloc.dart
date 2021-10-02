import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper/src/api_lib/api_response_wraper.dart';
import 'package:paper/src/app/bloc/news_search/home/home_state.dart';
import 'package:paper/src/app/bloc/search/search_event.dart';
import 'package:paper/src/app/repository/news/api/models/news_response.dart';
import 'package:paper/src/app/repository/news/news_repository.dart';
import 'package:paper/src/utils/screen_enum.dart';

class NewsSearchBloc extends Bloc<SearchEvent, HomeState> {
  NewsSearchBloc() : super(const InitialSearchState(Screens.SEARCH));

  @override
  Stream<HomeState> mapEventToState(SearchEvent event) async* {
    yield const LoadingSearchState(Screens.SEARCH);
    if (event is SearchModule) {
      try {
        final ApiResponseWrapper<NewsResponse> searchResponse =
            await NewsRepository()
                .searchNews(page: event.page, query: event.query);
        if (searchResponse.data == null ||
            searchResponse.data!.status == 'error') {
          yield SearchErrorState(searchResponse.getException, Screens.SEARCH);
        } else {
          yield LoadedSearchState(searchResponse, Screens.SEARCH);
        }
      } on NullThrownError {
        yield const SearchApiErrorState(null, Screens.SEARCH);
      } catch (e) {
        yield const SearchApiErrorState(null, Screens.SEARCH);
      }
    }
  }
}
