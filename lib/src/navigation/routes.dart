import 'package:flutter/cupertino.dart';
import 'package:paper/src/app/ui/home/home_screen.dart';
import 'package:paper/src/app/ui/news_detail/news_detail_screen.dart';
import 'package:paper/src/app/ui/search/news_search_screen.dart';

class Routes {
  Routes._();
  static const kHomeScreen = '/';
  static const kNewsDetailScreen = '/news_detail';
  static const kNewsSearchScreen = '/news_search';
  static final routes = <String,WidgetBuilder>{
    kHomeScreen:(context)=>HomeScreen(),
    kNewsDetailScreen:(context)=>const NewsDetailScreen(),
    kNewsSearchScreen:(context)=> NewsSearchScreen()
  };
}