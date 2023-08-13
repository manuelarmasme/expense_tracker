import 'package:uuid/uuid.dart';

const uuid = Uuid();

//enum is another dart feature that help us in this case don't let to the user
//to much flexibility accepting any kind of values even those who has a typo
//flutter recognize all those values kind of some strings
enum Category {food, travel, leisure, work}

class Expense{

  // this kind of form that we are using to initialize id is a initializer list
  //this is a dart feature that helps us to initialize some kind of variable that aren't passing to the constructor

  Expense({
    required this.title,
    required this.date,
    required this.amount,
    required this.category
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  //this is an special custom type using the enum that we define later on
  final Category category;
}