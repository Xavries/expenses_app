import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _openDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 5, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Назва витрат')
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    label: Text('Сума')
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('selected date'),
                    IconButton(onPressed: _openDatePicker, icon: Icon(Icons.calendar_month))
                  ],
                )
                )
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {Navigator.pop(context);},
                child: Text('Закрити')
              ),
              ElevatedButton(
                onPressed: () {print('fff');},
                child: Text('Зберегти')
              ),
            ],
          )
        ],
      ),
      );
  }
}