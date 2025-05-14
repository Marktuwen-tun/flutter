import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../controllers/transaction_controller.dart';
import '../widgets/transaction_list.dart';
import 'add_transaction.dart';
import 'package:Accounting_software/widgets/chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TransactionController _controller = TransactionController();

  @override
  void initState() {
    super.initState();
    _controller.loadFromPrefs().then((_) {
      setState(() {});
    });
  }

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _controller.addTransaction(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => AddTransaction(addTx: _addNewTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recentTransactions = _controller.transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('记账本'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(recentTransactions: recentTransactions),
          Expanded(
            child: TransactionList(transactions: _controller.transactions),
          ),
        ],
      ),
    );
  }
}
