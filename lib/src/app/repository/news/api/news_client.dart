import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:retrofit/http.dart';
import '../api/models/news_response.dart';

part 'news_client.g.dart';

@RestApi(baseUrl: AppStrings.BASE_URL)
abstract class NewsClient {
  factory NewsClient(Dio dio) => _NewsClient(dio);

  @GET('/top-headlines')
  Future<NewsResponse> getTopHeadLines({
    @required @Query('page') int? page,
    @Query('country') String? country,
    @Query('category') String? category,
  });

  @GET('/everything')
  Future<NewsResponse> searchNews({
    @required @Query('page') int? page,
    @Query('q') String? q,
  });

}
