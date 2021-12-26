import 'package:paper/src/api_lib/api_exception.dart';
import 'package:paper/src/api_lib/api_response_wraper.dart';
import 'package:paper/src/app/repository/news/api/models/news_response.dart';

abstract class HomeState {
  const HomeState();
}

class InitialSearchState extends HomeState {
  const InitialSearchState() : super();

  List<Object> get props => [];
}

class LoadingSearchState extends HomeState {
  const LoadingSearchState() : super();

  List<Object> get props => [];
}

class LoadedSearchState extends HomeState {
  final ApiResponseWrapper<NewsResponse> searchResponse;

  const LoadedSearchState(this.searchResponse) : super();

  List<Object> get props => [searchResponse];
}

class SearchApiErrorState extends HomeState {
  final NullThrownError? error;

  const SearchApiErrorState(this.error) : super();

  List<Object?> get props => [error];
}

class SearchErrorState extends HomeState {
  final ServerError? error;

  const SearchErrorState(this.error) : super();

  List<Object?> get props => [error];
}
