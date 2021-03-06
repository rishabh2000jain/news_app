import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  final Function searchData;
  const SearchView({
    required this.textController,
    required this.size,
    required this.searchData,
    Key? key
  })  :super(key: key);

  final Size size;
  final TextEditingController textController;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      width: widget.size.width * 0.78,
      height: widget.size.width * 0.2,
      child: TextField(
        controller: widget.textController,
        cursorColor: theme.primaryVariant,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: theme.primaryVariant,
          ),
          hintText: 'Search Here',
          prefixIcon: _isFocused
              ? null
              : const Icon(
                  Icons.search,
                  color: Colors.deepOrange,
                ),
          suffixIcon: _isFocused
              ? IconButton(
                  onPressed: () {
                    widget.textController.text = '';
                  },
                  icon: Icon(
                    Icons.clear,
                    color: theme.primaryVariant,
                    size: 20,
                  ),
                )
              : null,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.deepOrange, width: 3, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white38, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onTap: () {
          setState(() {
            _isFocused = true;
          });
        },
        onSubmitted: (query) {
          setState(() {
            _isFocused = false;
          });
          widget.searchData(query);
        },
      ),
    );
  }
}

