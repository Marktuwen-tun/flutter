import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  final Function(String, double) addTx;

  const AddTransaction({super.key, required this.addTx});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text) ?? 0;

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget.addTx(enteredTitle, enteredAmount);
    Navigator.of(context).pop(); // 关闭弹出框
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
