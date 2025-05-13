import '../models/transaction.dart';

class TransactionController {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction tx) {
    _transactions.add(tx);
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
  }
}
