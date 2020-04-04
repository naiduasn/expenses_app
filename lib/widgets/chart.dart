import 'package:expenses_app/widgets/chart_bars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTxn;
  Chart(this.recentTxn);

  List<Map<String, Object>> get groupedTxns {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (int i = 0; i < recentTxn.length; i++) {
        if (recentTxn[i].date.day == weekday.day &&
            recentTxn[i].date.month == weekday.month &&
            recentTxn[i].date.year == weekday.year) {
          totalAmount += recentTxn[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekday), 'amount': totalAmount};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTxns.fold(0.0, (sum, txn) {
      return sum + txn['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTxns);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTxns.map((data) {
            return ChartBars(data['day'], data['amount'],
                totalSpending == 0 ? 0.0 : (data['amount'] as double) / totalSpending);
            //return Text('${data['day']} : ${data['amount']}');
          }).toList(),
        ),
      ),
    );
  }
}
