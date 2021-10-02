import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/constants/app_constants.dart';

class CategoryChipList extends StatefulWidget {
  Function categorySelected;

  CategoryChipList({
    required this.categorySelected,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  State<CategoryChipList> createState() => _CategoryChipListState();
}

class _CategoryChipListState extends State<CategoryChipList> {
  int _pos = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: AppConstants.NEWS_CATEGORY.length,
          padding: const EdgeInsets.only(left: 10),
          itemBuilder: (context, pos) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ChoiceChip(
                label: Text(
                  AppConstants.NEWS_CATEGORY[pos],
                  style: TextStyle(
                      color: widget.colorScheme.primary,
                      fontWeight: FontWeight.w900),
                ),
                selectedColor: widget.colorScheme.primaryVariant,
                selected: this._pos == pos,
                disabledColor: widget.colorScheme.primaryVariant,
                onSelected: (selected) {
                  setState(() {
                    this._pos = pos;
                    widget.categorySelected(AppConstants.NEWS_CATEGORY[pos]);
                  });
                },
              ),
            );
          }),
    );
  }
}
