import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

part 'expense.g.dart';

final dateFormatter = DateFormat('EEE d/M/y');

const uuid = Uuid();

enum Category {market, caffe, travel, pets, other}

const categoryIcons = {
  Category.market: Icons.store,
  Category.caffe: Icons.coffee,
  Category.travel: Icons.directions_car_filled_outlined,
  Category.pets: Icons.pets,
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
    List<ExpenseDbModel> allExpenses, this.category
  ) : expenses = allExpenses.where(
    (expense) => expense.category == category
    ).toList();

  final Category category;
  final List<ExpenseDbModel> expenses;

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
  // ExpenseDbModel(
  //   {
  //     this.id = Isar.autoIncrement,
  //     required this.title,
  //     required this.amount,
  //     required this.date,
  //     required this.category,
  //   }
  // );

  Id id = Isar.autoIncrement;
  late String title;
  late double amount;
  late DateTime date = DateTime.now();
  @enumerated
  late Category category = Category.caffe;

  String get humanDate {
    return dateFormatter.format(date);
  }
}
