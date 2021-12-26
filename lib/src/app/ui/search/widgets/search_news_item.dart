import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/common/image_widget.dart';
import 'package:paper/src/navigation/app_router.dart';

class SearchNewsItem extends StatelessWidget {
  const SearchNewsItem({
    required Article articles,
    required this.size,
    required this.theme,
    Key? key,
  })  : _articles = articles,
        super(key: key);

  final Article _articles;
  final Size size;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.moveToNewsDetailScreen(context, _articles);
      },
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 80,
            width: size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 90,
                  height: 50,
                  child: CommonImageView(
                    height: 50,
                    width: 90,
                    imageUrl: _articles.urlToImage,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    _articles.title ?? '__',
                    style: theme.textTheme.headline5!.copyWith(
                      fontSize: 20,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
