import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/utils/app_util.dart';

class CommonImageView extends StatelessWidget {
  const CommonImageView(
      {this.width, required this.height, required this.imageUrl, Key? key})
      : super(key: key);
  final String? imageUrl;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      AppUtil.isStringEmpty(imageUrl ?? '')
          ? AppStrings.kBrokenImage
          : imageUrl!,
      height: height,
      width: width,
      fit: BoxFit.fill,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, obj, stack) {
        return Image.asset(
          AppStrings.kBrokenImage,
          height: 300.0,
          fit: BoxFit.fill,
        );
      },
    );
  }
}
