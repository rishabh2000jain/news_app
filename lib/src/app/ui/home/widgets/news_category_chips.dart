import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/constants/app_constants.dart';

class CategoryChipList extends StatefulWidget {
  Function categorySelected;

  CategoryChipList({Key? key,
    required this.categorySelected,
    required this.colorScheme,
  }) : super(key: key);

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
          itemCount: AppConstants.kNewsCategory.length,
          padding: const EdgeInsets.only(left: 10),
          itemBuilder: (context, pos) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ChoiceChip(
                label: Text(
                  AppConstants.kNewsCategory[pos]),
                selected: this._pos == pos,
                onSelected: (selected) {
                  setState(() {
                    this._pos = pos;
                    widget.categorySelected(AppConstants.kNewsCategory[pos]);
                  });
                },
              ),
            );
          }),
    );
  }
}
