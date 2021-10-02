import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/navigation/app_router.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/utils/app_util.dart';

class SearchNewsItem extends StatelessWidget {
  const SearchNewsItem({
    Key? key,
    required Articles articles,
    required this.size,
    required this.colorScheme,
  })  : _articles = articles,
        super(key: key);

  final Articles _articles;
  final Size size;
  final colorScheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.moveToNewsDetailScreen(context, _articles);
      },
      child: Card(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 80,
            width: size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 90,
                  height: 50,
                  child: Image.network(
                    AppUtil.isStringEmpty(_articles.urlToImage ?? '')
                        ? AppStrings.BrokenImage
                        : _articles.urlToImage!,
                    height: 50,
                    width: 90,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Align(
                        alignment: Alignment.center,
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
                        height: 50.0,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    _articles.title ?? '__',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: colorScheme.primaryVariant,
                        overflow: TextOverflow.ellipsis),
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
