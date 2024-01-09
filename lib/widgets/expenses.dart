import 'package:flutter/material.dart';

import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/new_expense.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_app/widgets/chart/chart.dart';
import 'package:expenses_app/isar_service.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  final service = IsarService();
  DateTimeRange _expensesDateRange = DateTimeRange(
    end: DateTime.now(),
    start: DateTime(
        DateTime.now().year,
        DateTime.now().month - 1,
        DateTime.now().day
      )
    );

  final List<Expense> _registeredExpenses = [
    Expense(title: 'Test1', amount: 11.1, date: DateTime.now(), category: Category.market),
        Expense(title: 'Test2', amount: 21.1, date: DateTime.now(), category: Category.caffe)

  ];

  void _openAddExpense() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense,)
      );
  }

  void _addExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _removeExpense(ExpenseDbModel expense) {

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 8),
        content: const Text('Витрату видалено'),
        action: SnackBarAction(
          label: 'Повернути', onPressed: () {
            service.saveExpenseDbModel(ExpenseDbModel()
              ..title = expense.title
              ..amount = expense.amount
              ..date = expense.date
              ..category = expense.category
            );
          }
          ),
        )
      );
      service.removeExpense(expense);
  }

  void _openDateRangePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 5, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    DateTimeRange? pickedDate = await showDateRangePicker(context: context, firstDate: firstDate, lastDate: lastDate);

    setState(() {
      if (pickedDate != null) {
        _expensesDateRange = pickedDate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('Немає витрат.'),);

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses, onRemoveExpense: _removeExpense, expensesDateRange: _expensesDateRange
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мої фінанси'),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //         Colors.orange.shade900,
        //         Colors.orange.shade500,
        //         Colors.orange.shade100,
        //       ],
        //     ),
        //   ),
        // ),
        // backgroundColor: Color(LinearGradient(colors: [Color(Colors.green), Color(Colors.blue)])),
        actions: [
        IconButton(
          onPressed: _openDateRangePicker,
          icon: const Icon(Icons.calendar_month)
          ),
        IconButton(
          onPressed: _openAddExpense,
          icon: const Icon(Icons.add)
          )
        ]),
      // body: Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [
      //         Colors.orange,
      //         Color.fromARGB(255, 78, 13, 151),
      //       ],
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter
      //       )
      //   ),
        body: Column(children: [
          // Chart(expenses: _registeredExpenses),
          Chart(expensesDateRange: _expensesDateRange),
          Expanded(child: mainContent)
          ]),
      // ),
      );
  }
}