import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/app/ui/search/widgets/search_news_item.dart';
import 'package:paper/src/navigation/app_router.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/utils/app_util.dart';

class SearchList extends StatelessWidget {
  SearchList({
    required List<Articles> articles,
    required this.colorScheme,
    required ScrollController controller,
    required bool hasNext,
    Key? key,
  })  : _hasNext = hasNext,
        _articles = articles,
        _controller = controller,
        super(key: key);
  ScrollController _controller;
  late List<Articles> _articles;
  final colorScheme;
  bool _hasNext;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.builder(
          controller: _controller,
          itemCount: _hasNext ? _articles.length + 1 : _articles.length,
          itemBuilder: (context, pos) {
            return pos >= _articles.length
                ? Align(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                : SearchNewsItem(
                    articles: _articles[pos],
                    size: size,
                    colorScheme: colorScheme);
          }),
    );
  }
}
