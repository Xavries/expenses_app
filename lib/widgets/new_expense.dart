import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense newExpense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.caffe; 

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 5, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    final pickedDate = await showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveNewExpense () {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || amountInvalid || _selectedDate == null) {
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Невірні дані!'),
        content: const Text('Перевірте назву, кількість та дату.'),
        actions: [
          TextButton(onPressed: () {Navigator.pop(ctx);}, child: const Text('OK'))
        ],
      ));
      return;
    }

    widget.onAddExpense(Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory
      ));
    
    Navigator.pop(context);
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
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
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
                    Text(_selectedDate == null ? 'Виберіть дату' : dateFormatter.format(_selectedDate!)),
                    IconButton(onPressed: _openDatePicker, icon: Icon(Icons.calendar_month))
                  ],
                )
                )
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map(
                  (category) => DropdownMenuItem(value: category, child: Text(category.name.toUpperCase()))
                  ).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                }
                ),
              const Spacer(),
              TextButton(
                onPressed: () {Navigator.pop(context);},
                child: Text('Закрити')
              ),
              ElevatedButton(
                onPressed: _saveNewExpense,
                child: Text('Зберегти')
              ),
            ],
          )
        ],
      ),
      );
  }
}