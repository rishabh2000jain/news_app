import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper/src/api_lib/api_response_wraper.dart';
import 'package:paper/src/app/repository/news/api/models/news_response.dart';
import 'package:paper/src/app/repository/news/news_repository.dart';
import 'package:paper/src/utils/screen_enum.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(InitialSearchState initialSearchState) : super(initialSearchState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield const LoadingSearchState(Screens.HOME);
    if (event is HomeModule) {
      try {
        final ApiResponseWrapper<NewsResponse> searchResponse =
            await NewsRepository().getTopHeadlines(
                page: event.page,
                category: event.category?.toLowerCase() ?? 'general',
                country: event.country?.toLowerCase() ?? 'in');
        if (searchResponse.data == null ||
            searchResponse.data!.status == 'error') {
          yield SearchErrorState(searchResponse.getException,Screens.HOME);
        } else {
          yield LoadedSearchState(searchResponse,Screens.HOME);
        }
      } on NullThrownError {
        yield const SearchApiErrorState(null,Screens.HOME);
      } catch (e) {
        yield const SearchApiErrorState(null,Screens.HOME);
      }
    }
  }
}
