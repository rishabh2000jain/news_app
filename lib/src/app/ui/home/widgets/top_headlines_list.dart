import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';

import 'news_list_item.dart';

class TopHeadlinesList extends StatelessWidget{
  final ScrollController _controller;
  bool _hasNextPage;

  TopHeadlinesList({
    required ScrollController controller,
    required List<Articles> articlesList,
    required bool hasNextPage,
    Key? key,
  })  : _articlesList = articlesList,
        _controller = controller,
        _hasNextPage = hasNextPage,
        super(key: key);

  final List<Articles> _articlesList;

  @override
  build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _controller,
        itemCount: _hasNextPage
            ? _articlesList.length + 1
            : _articlesList.length,
        itemBuilder: (context, pos) => pos >= _articlesList.length
            ? Align(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : NewsItem(articles: _articlesList[pos]));
  }
}
