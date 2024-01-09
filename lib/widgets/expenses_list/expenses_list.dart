import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/isar_service.dart';


class ExpensesList extends StatelessWidget {
  ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
    required this.expensesDateRange,
  });

  final List<Expense> expenses;
  final void Function(ExpenseDbModel expense) onRemoveExpense;
  final DateTimeRange expensesDateRange;
  final service = IsarService();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<ExpenseDbModel>>(
      future: service.getAllExpenseDbModels(expensesDateRange),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());
        if (snapshot.hasData) {
          List<ExpenseDbModel> dbExpensesFromFuture = snapshot.data!.reversed.toList();
          if (dbExpensesFromFuture.isEmpty) {
            return const Center(child: Text("Немає записів"));
          }
          else {
            return ListView.builder(
              itemCount: dbExpensesFromFuture.length, itemBuilder: (ctx, index) => Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.scrim,
                margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal
                ),
              ),
              key: ValueKey(dbExpensesFromFuture[index]),
              onDismissed: (direction) {
                onRemoveExpense(dbExpensesFromFuture[index]);
              },
              child: ExpensesItem(dbExpensesFromFuture[index])
              )
            );
          }
        }
        return const Center(child: Text("Немає даних"));
      },
    );
  }
}