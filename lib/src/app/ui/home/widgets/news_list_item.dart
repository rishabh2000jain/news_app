import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/constants/app_constants.dart';
import 'package:paper/src/navigation/app_router.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/utils/app_util.dart';

class NewsItem extends StatelessWidget {
  final Articles articles;

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
        color: Theme.of(context).colorScheme.primary,
        elevation: 10.0,
        margin: AppConstants.EDGE_INSETS_10,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 300,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                AppUtil.isStringEmpty(articles.urlToImage ?? '')
                    ? AppStrings.BrokenImage
                    : articles.urlToImage!,
                height: 300.0,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondaryVariant,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, obj, stack) {
                  return Image.asset(
                    AppStrings.BrokenImage,
                    height: 300.0,
                    fit: BoxFit.fill,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Text(
                  '${articles.title}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 21,
                      color: Colors.white,
                      backgroundColor: Colors.black38,
                      overflow: TextOverflow.ellipsis),
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
