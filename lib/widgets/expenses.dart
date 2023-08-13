import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  //this is a private variable only available on this file
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        date: DateTime.now(),
        amount: 19.99,
        category: Category.work),
    Expense(
        title: 'Cinema',
        date: DateTime.now(),
        amount: 29,
        category: Category.leisure
      )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Chart'),
          //Expanded helps us to renderized this list because deep inside this widget is using column
          //so in this kind of case it won't show
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
