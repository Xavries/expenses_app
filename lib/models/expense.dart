import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

part 'expense.g.dart';

final dateFormatter = DateFormat('EEE d/M/y');

const uuid = Uuid();

enum Category {market, caffe, travel, other}

const categoryIcons = {
  Category.market: Icons.store,
  Category.caffe: Icons.coffee,
  Category.travel: Icons.card_travel,
  Category.other: Icons.money
};

class Expense {
  Expense(
    {
      required this.title,
      required this.amount,
      required this.date,
      required this.category,
    }
  ) : id = uuid.v4();


  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get humanDate {
    return dateFormatter.format(date);
  }
}

class ExpenseCollectorFilter {
  const ExpenseCollectorFilter({
    required this.category,
    required this.expenses,
  });

  ExpenseCollectorFilter.forCategory(
    List<Expense> allExpenses, this.category
  ) : expenses = allExpenses.where(
    (expense) => expense.category == category
    ).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}

@collection
class ExpenseDbModel {
  // title: 'Test1', amount: 11.1, date: DateTime.now(), category: Category.market
  
  // ExpenseDbModel({
  //   this.title,
  //   this.amount,
  //   this.date,
  //   this.category
  // });

  // Id id = Isar.autoIncrement;

  // @Index(type: IndexType.value)
  // final String? title;

  // final double? amount;

  // DateTime? date = DateTime.now();

  // Category? category = Category.caffe;

  Id id = Isar.autoIncrement;
  late String title;
  late double amount;
  late DateTime? date = DateTime.now();
  @enumerated
  late Category category = Category.caffe;
}

// void initIsarSchema() async {

//   final dir = await getApplicationDocumentsDirectory();
//   final isar = await Isar.open(
//     [ExpenseDbModel],
//     directory: dir.path,
//   );

// }