import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper/src/api_lib/api_response_wraper.dart';
import 'package:paper/src/app/repository/news/api/models/news_response.dart';
import 'package:paper/src/app/repository/news/news_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(InitialSearchState initialSearchState) : super(initialSearchState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield const LoadingSearchState();
    if (event is HomeModule) {
      try {
        final ApiResponseWrapper<NewsResponse> searchResponse =
            await NewsRepository().getTopHeadlines(
                page: event.page,
                category: event.category?.toLowerCase() ?? 'general',
                country: event.country?.toLowerCase() ?? 'in');
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
