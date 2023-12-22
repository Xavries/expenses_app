import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/isar_service.dart';


class ExpensesList extends StatelessWidget {
  ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(ExpenseDbModel expense) onRemoveExpense;
  final service = IsarService();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<ExpenseDbModel>>(
      future: service.getAllExpenseDbModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());
        if (snapshot.hasData) {
          List<ExpenseDbModel> dbExpensesFromFuture = snapshot.data!;
          if (dbExpensesFromFuture.isEmpty) {
            return const Text("Немає записів");
          }
          else {
            return ListView.builder(
              reverse: true,
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
        return const Text("Немає даних");
      },
    );
  }
}