import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/common/image_widget.dart';
import 'package:paper/src/navigation/app_router.dart';

class NewsItem extends StatelessWidget {
  final Article articles;

  const NewsItem({
    required this.articles,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.moveToNewsDetailScreen(context, articles);
      },
      child: Card(
        child: SizedBox(
          height: 300,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CommonImageView(height: 300.0, imageUrl: articles.urlToImage),
              Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.black54,
                height: 80.0,
                child: Center(
                  child: Text(
                    '${articles.title}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
