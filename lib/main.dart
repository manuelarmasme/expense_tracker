import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';


//k is aconverntion on flutter to set up a color scheme
//from seed allows us to  create a lot of diferrent type of contrast color with one color seed
var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181),);

void main() {
  runApp(
    MaterialApp(
      //using copyWith with can just copy the default settings from a theme and then ovewritting
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
        ),
        //in this case elevatedButtonTheme hasnt any copywith property
        //so in some cases we can use copywith or stylefrom
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 16
          )
        ),
      ),
      home: const Expenses(),
    )
  );
}

