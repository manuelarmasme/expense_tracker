import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

//enum is another dart feature that help us in this case don't let to the user
//to much flexibility accepting any kind of values even those who has a typo
//flutter recognize all those values kind of some strings
enum Category { food, travel, leisure, work }

//this is a map with key value
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  // this kind of form that we are using to initialize id is a initializer list
  //this is a dart feature that helps us to initialize some kind of variable that aren't passing to the constructor

  Expense(
      {required this.title,
      required this.date,
      required this.amount,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  //this is an special custom type using the enum that we define later on
  final Category category;

  //getter to format date
  String get formattedDate {
    return formatter.format(date);
  }
}

// class expense buckets, works for summarize every expense that we have
class ExpenseBucket {
  //constructor function
  const ExpenseBucket({required this.category, required this.expenses});

  //creating another constructor
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            //using where we are filtering and toList help us to return a list
            //because wheres is returning and a iterable
            .where((expense) => expense.category == category)
            .toList();

  //variables
  final Category category;
  final List<Expense> expenses;

  //getter, to start the sum of every expense
  double get totalExpenses {
    double sum = 0;

    //for in is a  better option
    for (final expense in expenses) {
      sum += expense.amount; // this is equal to sum = sum + expenses.amount
    }

    return sum;
  }
}
