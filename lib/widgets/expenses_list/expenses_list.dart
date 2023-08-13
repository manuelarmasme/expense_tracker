import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    //we are using List View when we don't know the length of the list that we are going to render
    //If we use column on this kind of case we're going to have an perfomance issue
    //builder tells flutter that create a scrollable list only with the visible or almost visible elements, not if there not visible
    //if we have a long list of item this help us to increment significally the perfomance app
    return ListView.builder(
        //Item Count define how many list item will it be render finally
        //with itemCount we are telling flutter how many items should be display
        itemCount: expenses.length,

        //in this case we want to show expese title
        //ctx => context
        itemBuilder: (ctx, index) => ExpenseItem(expenses[index])
      );
  }
}
