import 'package:expenses_app/expenses_list.dart';
import 'package:flutter/material.dart';

import 'package:expenses_app/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  final List<Expense> _registeredExpenses = [
    Expense(title: 'Test1', amount: 11.1, date: DateTime.now(), category: Category.market),
        Expense(title: 'Test2', amount: 21.1, date: DateTime.now(), category: Category.caffe)

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text('chart'), Expanded(child: ExpensesList(expenses: _registeredExpenses))]),);
  }
}