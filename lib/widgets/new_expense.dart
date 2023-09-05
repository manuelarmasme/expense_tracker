import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //We are creating a controller that helps a lot to update de info on the inputs fields

  final _titletController = TextEditingController();
  final _amountController = TextEditingController();

  //datetime variable to store pickedDate
  // ? this tells dart that the variable at the begining can be null
  DateTime? _selectedDate;

  //this variable helps us to control the dropdown value
  Category _selectedCategory = Category.leisure;

  // _presentDatePicker helps us to show the date modal picker
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    //to convert the string of amount controller, we have to use the double property tryparse
    final enteredAmount = double.tryParse(_amountController.text);

    //we compares if _enteredAmount is null because tryparse if it has and strings its returns null
    // if _enteredAmount is equal o less than 0 we want the user puts another value
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;

    //if to show error
    if (_titletController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      //_titletController.text is the form to access to the value submited
      //trim delete spaces at the begin and in the end of the string
      //isEmpty expect an String or list an the result of the trim is an string
      // if _selectedDate still null we have to show an error

      //this dialog shows an alert dialog with an button
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: const Text('Invalid input'),
                  content: const Text(
                      'Please make sure a valid title, amount, date and category was entered'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text('Okay'))
                  ]));
      //this return helps to break the function and don't continue reading the code
      return;
    }

    //saving an expenses
    //to access to the  onAddExpense we have to use widget
    // we use ! to force flutter and let him know that in this case we know that date is not null

    widget.onAddExpense(
      Expense(
          title: _titletController.text,
          date: _selectedDate!,
          amount: enteredAmount,
          category: _selectedCategory),
    );

    //close the overlay when a expense is added
    Navigator.pop(context);
  }

  //this helps us to detroy the _titletController that keeps on memory when  the widget is no loger need it
  @override
  void dispose() {
    _titletController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titletController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixText: '\$', label: Text('Amount')),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Selected date'
                        //with ! we're telling flutter to understand that at the end we are having a datetime
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                //value helps to get a selected value when the user selected one value it will show
                //on the dropdownmenu
                value: _selectedCategory,
                //items needs a DropdownMenuItem list and in this case category is an enum
                //for that reason with map we're going to transform into a DropdownMenuItem list
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        //in this case we are telling that this is the value that you have to store internally, when the user selected
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  //this helps us to dont go to the set state, if the dropdown value is null
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  //Navigator .pop needs the context of the flutter to close the overlay
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                },
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
