import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/app/ui/search/widgets/search_news_item.dart';

class SearchList extends StatelessWidget {
  const SearchList({
    required List<Article> articles,
    required this.theme,
    required ScrollController controller,
    required bool hasNext,
    Key? key,
  })  : _hasNext = hasNext,
        _articles = articles,
        _controller = controller,
        super(key: key);
  final ScrollController _controller;
  final List<Article> _articles;
  final ThemeData theme;
  final bool _hasNext;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: ListView.builder(
          controller: _controller,
          itemCount: _hasNext ? _articles.length + 1 : _articles.length,
          itemBuilder: (context, pos) {
            return pos >= _articles.length
                ? const Align(
                    child: CircularProgressIndicator(),
                  )
                : SearchNewsItem(
                    articles: _articles[pos], size: size, theme: theme);
          }),
    );
  }
}
