import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_app/widgets/new_expense.dart';
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

  void _openAddExpense() {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => const NewExpense()
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Веди фінанси'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange.shade900,
                Colors.orange.shade500,
                Colors.orange.shade100,
              ],
            ),
          ),
        ),
        // backgroundColor: Color(LinearGradient(colors: [Color(Colors.green), Color(Colors.blue)])),
        actions: [
        IconButton(
          onPressed: _openAddExpense,
          icon: const Icon(Icons.add)
          )
        ]),
      body: Column(children: [
        const Text('chart'),
        Expanded(child: ExpensesList(expenses: _registeredExpenses))
        ]),);
  }
}