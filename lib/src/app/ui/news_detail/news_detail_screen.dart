import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/app/repository/news/api/models/articles.dart';
import 'package:paper/src/constants/app_constants.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/utils/app_util.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as Article;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            //backgroundColor: theme.colorScheme.primary,
            pinned: true,
            snap: false,
            floating: false,
            title: Text(
              args.source?.name ?? '',
              style: theme.textTheme.headline5,
            ),
            expandedHeight: size.height * 0.7,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                '${AppUtil.isStringEmpty(args.urlToImage ?? '') ? AppStrings.BrokenImage : args.urlToImage}',
                errorBuilder: (context, _, stack) {
                  return Image.asset(
                    AppStrings.BrokenImage,
                  );
                },
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
              [
                AppConstants.kSpacer_15,
                Text(
                  args.title ?? 'No Title',
                  style: theme.textTheme.headline5,
                ),
                AppConstants.kSpacer_10,
                Text(
                  'Author:  ${args.author ?? '___'}',
                  style: theme.textTheme.headline6!.copyWith(
                      color: Colors.lightGreen,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Date:  ${args.publishedAt?.substring(0, 10) ?? '___'}',
                  style: theme.textTheme.headline6!.copyWith(
                      color: Colors.lightBlue,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                AppConstants.kSpacer_15,
                Text(
                  '${args.description ?? ''}.',
                  style: theme.textTheme.bodyText1,
                  textAlign: TextAlign.start,
                ),
                AppConstants.kSpacer_15,
                Text(
                  '${args.content ?? ''}.',
                  style: theme.textTheme.bodyText1,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.visible,
                ),
                AppConstants.kSpacer_15,
                InkWell(
                  child: const Text(
                    'Open In Browser',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 22,
                        fontStyle: FontStyle.italic),
                  ),
                  onTap: () {
                    launch(args.url.toString());
                  },
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
