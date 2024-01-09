import 'package:flutter/material.dart';

import 'package:expenses_app/widgets/chart/chart_bar.dart';
import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/isar_service.dart';

class Chart extends StatelessWidget {
  Chart({
    super.key,
    required this.expensesDateRange,
    });

  final service = IsarService();
  final DateTimeRange expensesDateRange;

  List<ExpenseCollectorFilter> buckets (dbExpenses) {
    return [
      ExpenseCollectorFilter.forCategory(dbExpenses, Category.caffe),
      ExpenseCollectorFilter.forCategory(dbExpenses, Category.market),
      ExpenseCollectorFilter.forCategory(dbExpenses, Category.travel),
      ExpenseCollectorFilter.forCategory(dbExpenses, Category.pets),
      ExpenseCollectorFilter.forCategory(dbExpenses, Category.other),
    ];
  }

  double maxTotalExpense (buckets) {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  Text getExpensesSum (List<ExpenseCollectorFilter> dbExpenses) {
    double totalExpensesSumm = 0;
    for (var bucket in dbExpenses) {
      totalExpensesSumm += bucket.totalExpenses;
    }
    return Text('Загалом: $totalExpensesSumm');
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return FutureBuilder<List<ExpenseDbModel?>>(
      future: service.getAllExpenseDbModels(expensesDateRange),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('Chart generation is in progress...'));
        }
        final dbExpensesFromFuture = buckets(snapshot.data);

        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
                Theme.of(context).colorScheme.primary.withOpacity(0.0)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final bucket in dbExpensesFromFuture) // alternative to map()
                      ChartBar(
                        fill: bucket.totalExpenses == 0
                            ? 0
                            : bucket.totalExpenses / maxTotalExpense(dbExpensesFromFuture),
                      )
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: dbExpensesFromFuture
                    .map(
                      (bucket) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            bucket.totalExpenses.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Row(
                children: dbExpensesFromFuture
                    .map(
                      (bucket) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            categoryIcons[bucket.category],
                            color: isDarkMode
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.7),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Container(child: getExpensesSum(dbExpensesFromFuture),)
            ],
          ),
        );
      }
    );
  }
}