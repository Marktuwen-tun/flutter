import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? const Center(child: Text('暂无记录'))
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tx = transactions[index];
              return Card(
                child: ListTile(
                  title: Text(tx.title),
                  subtitle: Text(tx.date.toLocal().toString()),
                  trailing: Text('\$${tx.amount.toStringAsFixed(2)}'),
                ),
              );
            },
          );
  }
}
