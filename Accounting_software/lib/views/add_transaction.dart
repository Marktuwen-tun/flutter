import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  final Function(String, double, String) addTx;

  const AddTransaction({super.key, required this.addTx});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String _selectedCategory = '饮食';

  final List<String> _categories = ['饮食', '交通', '娱乐', '购物', '医疗', '其他'];

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text) ?? 0;

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget.addTx(enteredTitle, enteredAmount, _selectedCategory);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: '标题'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: '金额'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: submitData,
              child: const Text('添加'),
            )
          ],
        ),
      ),
    );
  }
}
