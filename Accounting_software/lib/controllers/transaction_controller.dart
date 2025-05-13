import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';

class TransactionController {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  Future<void> addTransaction(Transaction tx) async {
    _transactions.add(tx);
    await _saveToPrefs();
  }

  Future<void> deleteTransaction(String id) async {
    _transactions.removeWhere((tx) => tx.id == id);
    await _saveToPrefs();
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('transactions');
    if (data != null) {
      final List decoded = json.decode(data);
      _transactions.clear();
      _transactions.addAll(decoded.map((e) => Transaction.fromJson(e)).toList());
    }
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _transactions.map((tx) => tx.toJson()).toList();
    prefs.setString('transactions', json.encode(jsonList));
  }
}
