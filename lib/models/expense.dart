import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

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