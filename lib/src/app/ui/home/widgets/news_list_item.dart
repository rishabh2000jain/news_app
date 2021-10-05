import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/common/image_widget.dart';
import 'package:paper/src/constants/app_constants.dart';
import 'package:paper/src/navigation/app_router.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/utils/app_util.dart';

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
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Text(
                  '${articles.title}',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline6!.copyWith(backgroundColor: Colors.black38,),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
