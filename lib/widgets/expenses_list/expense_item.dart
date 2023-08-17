import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget{
  const ExpenseItem(this.expense, {super.key});

  //this variable is type expense which it has all the properties that an expense has
  final Expense expense;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20
        ),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 4,),
            Row(
              children: [
                //${} this tells flutter that we are using the whole expresion
                //\$ this tells flutter that we want to render the dollar sign
                //toStringAsFixed helps us to show an string with only two decimals
                Text('\$${expense.amount.toStringAsFixed(2)}'),

                //Spacer is a widget that tells flutter that should create a widget that takes all the space that it available between two wigdets
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8,),
                    Text('${expense.formattedDate}')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}