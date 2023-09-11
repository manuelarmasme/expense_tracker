import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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
        category: Category.leisure)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      //ctx is the context for the modal element that is created by Flutter
      //this context has the info related to the modal bottom sheet instead of the expense
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  // add expense recevie a custom value type Expense
  void _addExpense(Expense expense) {
    setState(() {
      //set state helps to update de ui when the expense is added
      _registeredExpenses.add(expense);
    });
  }

  //remove expense item
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      //remove from _registeredExpenses and update the ui
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(
                expenseIndex,
                expense,
              );
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    //Expense list variable to know if there is more than zero expenses
    Widget mainContent = const Center(
      child: Text('There is not any expense found.'),
    );

    //if to check if the expense list is empty
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                //Expanded helps us to renderized this list because deep inside this widget is using column
                //so in this kind of case it won't show
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                //Expanded helps us to renderized this list because deep inside this widget is using column
                //so in this kind of case it won't show
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
