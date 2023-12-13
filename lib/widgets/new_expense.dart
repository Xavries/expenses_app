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
          TextField(
            keyboardType: TextInputType.number,
            controller: _amountController,
            maxLength: 20,
            decoration: const InputDecoration(
              label: Text('Сума')
            ),
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