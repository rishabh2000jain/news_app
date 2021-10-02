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
    final colorScheme = Theme.of(context).colorScheme;
    final args = ModalRoute.of(context)!.settings.arguments as Articles;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(
              color: colorScheme.primaryVariant, //change your color here
            ),
            elevation: 0,
            backgroundColor: colorScheme.primary,
            pinned: true,
            snap: false,
            floating: false,
            title: Text(
              args.source?.name ?? '',
              style: TextStyle(
                color: colorScheme.primaryVariant,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
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
                AppConstants.SPACER_15,
                Text(
                  args.title ?? 'No Title',
                  style: TextStyle(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstants.TITLE_FONT_SIZE,
                      fontFamily: AppStrings.PLAYFAIR_DISPLAY_FONT),
                ),
                AppConstants.SPACER_10,
                Text(
                  'Author:  ${args.author ?? '___'}',
                  style: const TextStyle(
                      fontSize: AppConstants.DESCRIPTION_FONT_SIZE,
                      color: Colors.lightGreen,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Date:  ${args.publishedAt?.substring(0, 10) ?? '___'}',
                  style: const TextStyle(
                      fontSize: AppConstants.DESCRIPTION_FONT_SIZE,
                      color: Colors.lightBlue,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                AppConstants.SPACER_15,
                Text(
                  '${args.description ?? ''}.',
                  style: TextStyle(
                      fontSize: AppConstants.DESCRIPTION_FONT_SIZE,
                      color: colorScheme.secondaryVariant,
                      letterSpacing: 1.2),
                  textAlign: TextAlign.start,
                ),
                AppConstants.SPACER_15,
                Text(
                  '${args.content ?? ''}.',
                  style: TextStyle(
                    fontSize: AppConstants.DESCRIPTION_FONT_SIZE,
                    color: colorScheme.secondaryVariant,
                    letterSpacing: .8,
                  ),
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.visible,
                ),
                AppConstants.SPACER_15,
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
