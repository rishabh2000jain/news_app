import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper/src/api_lib/api_response_wraper.dart';
import 'package:paper/src/app/bloc/home/home_state.dart';
import 'package:paper/src/app/bloc/search/search_event.dart';
import 'package:paper/src/app/repository/news/api/models/news_response.dart';
import 'package:paper/src/app/repository/news/news_repository.dart';

class NewsSearchBloc extends Bloc<SearchEvent, HomeState> {
  NewsSearchBloc(InitialSearchState initialSearchState) : super(initialSearchState);

  @override
  Stream<HomeState> mapEventToState(SearchEvent event) async* {
    yield const LoadingSearchState();
    if (event is SearchModule) {
      try {
        ApiResponseWrapper<NewsResponse> searchResponse =
            await NewsRepository()
                .searchNews(page: event.page, query: event.query);
        if (searchResponse.data == null ||
            searchResponse.data!.status == 'error') {
          yield SearchErrorState(searchResponse.getException);
        } else {
          yield LoadedSearchState(searchResponse);
        }
      } on NullThrownError {
        yield const SearchApiErrorState(null);
      } catch (e) {
        yield const SearchApiErrorState(null);
      }
    }
  }

}
