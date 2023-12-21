import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});


  final ExpenseDbModel expense;

  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(expense.title, style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(width: 4,),
          Row(children: [
            Text(expense.amount.toStringAsFixed(2)),
            const Spacer(),
            Row(children: [
              Icon(categoryIcons[expense.category]),
              const SizedBox(width: 8,),
              Text(expense.humanDate)
            ],)
            ],)
        ],
      ),
    ),);
  }
}