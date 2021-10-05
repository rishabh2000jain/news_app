import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:paper/src/api_lib/api_exception.dart';
import 'package:paper/src/api_lib/api_response_wraper.dart';
import 'package:paper/src/api_lib/service_manager.dart';
import 'package:paper/src/app/repository/news/api/models/news_response.dart';
import 'package:paper/src/app/repository/news/api/news_client.dart';

class NewsRepository {
  late final NewsClient _newsClient;
  final Logger _logger = Logger("NewsRepository");

  NewsRepository() {
    final dio = ServiceManager.get().getDioClient();
    _newsClient = NewsClient(dio);
  }

  ///This method returns the top headlines to Bloc.
  Future<ApiResponseWrapper<NewsResponse>> getTopHeadlines(
      {required int page, String? country, String? category}) async {
    NewsResponse response;
    try {
      response = await _newsClient.getTopHeadLines(
          page: page, country: country, category: category);
    } on DioError catch (e) {
      //if the error generated is of type DioError
      _logger.log(Level.INFO, "Exception occurred: getTopHeadlines", e);
      return ApiResponseWrapper()
        ..setException(ServerError.withError(error: e));
    } catch (exception, stackTrace) {
      _logger.log(Level.INFO, stackTrace);
      return ApiResponseWrapper()..setException(ServerError());
    }
    return ApiResponseWrapper()..data = response;
  }

  ///This method is for searching the news based on passed topic.
  Future<ApiResponseWrapper<NewsResponse>> searchNews(
      {required int page, required String query}) async {
    NewsResponse response;
    try {
      response = await _newsClient.searchNews(page: page, q: query);
    } on DioError catch (e) {
      //if the error generated is of type DioError
      _logger.log(Level.INFO, "Exception occurred: searchNews", e);
      return ApiResponseWrapper()
        ..setException(ServerError.withError(error: e));
    } catch (exception, stackTrace) {
      _logger.log(Level.INFO, stackTrace);
      return ApiResponseWrapper()..setException(ServerError());
    }
    return ApiResponseWrapper()..data = response;
  }
}
