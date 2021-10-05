
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper/src/constants/app_constants.dart';
import 'package:paper/src/shared_preference/app_preference.dart';

class CountryListWidget extends StatefulWidget {
  const CountryListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CountryListWidget> createState() => _CountryListWidgetState();
}

class _CountryListWidgetState extends State<CountryListWidget> {
  int _countryPos = AppPreferences.getCountry();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
          textStyle:
          MaterialStateProperty.all(Theme.of(context).textTheme.bodyText2),
        ),
        onPressed: () {
          AppPreferences.setCountry(_countryPos);
          Navigator.pop(context, _countryPos);
        },
        child: const Text('Submit'),
      ),
      Expanded(
        child: GridView.builder(
          itemCount: AppConstants.kCountry.length,
          itemBuilder: (context, pos) {
            return InkWell(
              onTap: () {
                setState(() {
                  _countryPos = pos;
                });
              },
              child: Card(
                  color: _countryPos == pos
                      ? Colors.black54
                      : Colors.lightBlueAccent,
                  child: Center(
                      child: Text(AppConstants.kCountry[pos].toUpperCase()))),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 0),
        ),
      ),
    ]);
  }
}
