import 'package:flutter/cupertino.dart';

class AppConstants {
  static const EDGE_INSETS_10 = EdgeInsets.all(10);
  static const BORDER_RADIUS = BorderRadius.all(Radius.circular(20));
  static const SEARCH_VIEW_HEIGHT = 45.0;
  static const CHIP_PADDING =
      EdgeInsets.symmetric(vertical: 10, horizontal: 18);
  static const CHIP_TEXT_STYLE = TextStyle(
    //color: AppColor.buttonTextAndIconColor,
    fontSize: 18,
    fontWeight: FontWeight.w900,
  );

  static const SEARCH_BAR_FONT_SIZE = 23.0;
  static const DESCRIPTION_FONT_SIZE = 22.0;
  static const TITLE_FONT_SIZE = 25.0;
  static const SPACER_10 = SizedBox(
    height: 10,
  );
  static const SPACER_15 = SizedBox(
    height: 15,
  );

  static const NEWS_CATEGORY = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];
}
