import 'package:flutter/material.dart';

import 'package:expenses_app/widgets/expenses.dart';


var kColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));

void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
      colorScheme: kColorScheme,
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme: CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primaryContainer
      )),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(fontSize: 20)
      )
      ),
    home: Expenses(),
  ));
}
