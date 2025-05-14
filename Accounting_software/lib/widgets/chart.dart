import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

 @override
Widget build(BuildContext context) {
  final data = groupedTransactionValues;

  return Card(
    elevation: 5,
    margin: const EdgeInsets.all(10),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 200,
        child: charts.BarChart(
          [
            charts.Series<Map<String, Object>, String>(
              id: '支出',
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (e, _) => e['day'] as String,
              measureFn: (e, _) => e['amount'] as double,
              data: data,
            ),
          ],
          animate: true,
        ),
      ),
    ),
  );
}

}
