
import 'package:paper/src/api_lib/api_exception.dart';
import 'package:paper/src/api_lib/api_response_wraper.dart';
import 'package:paper/src/app/repository/news/api/models/news_response.dart';
import 'package:paper/src/utils/screen_enum.dart';

abstract class HomeState {
  final Screens screens;
  const HomeState(this.screens);
}

class InitialSearchState extends HomeState {
  const InitialSearchState(Screens screens):super(screens);

  @override
  List<Object> get props => [];
}

class LoadingSearchState extends HomeState {
  const LoadingSearchState(Screens screens):super(screens);

  @override
  List<Object> get props => [];
}

class LoadedSearchState extends HomeState {
  final ApiResponseWrapper<NewsResponse> searchResponse;

  const LoadedSearchState(this.searchResponse,Screens screens):super(screens);

  @override
  List<Object> get props => [searchResponse];
}

class SearchApiErrorState extends HomeState {
  final NullThrownError? error;

  const SearchApiErrorState(this.error,Screens screens):super(screens);

  @override
  List<Object?> get props => [error];
}

class SearchErrorState extends HomeState {
  final ServerError? error;

  const SearchErrorState(this.error,Screens screens):super(screens);

  @override
  List<Object?> get props => [error];
}
