import 'package:flutter/cupertino.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/navigation/routes.dart';

class AppRouter{
  static void moveToNewsDetailScreen(BuildContext context , Article articles){
    Navigator.pushNamed(context, Routes.kNewsDetailScreen,
        arguments: articles);
  }
  static void moveToNewsSearchScreen(BuildContext context){
    Navigator.pushNamed(context, Routes.kNewsSearchScreen);
  }
}