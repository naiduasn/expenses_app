import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> txnList;
  final Function deleteTxnHandler;
  TransactionList(this.txnList, this.deleteTxnHandler);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 500,
        child: txnList.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No Transactions Yet',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                  Image.asset('assets/images/no_txn.png')
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                              "\u20B9" +
                                  txnList[index].amount.toStringAsFixed(2),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        txnList[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat().format(txnList[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () {
                          deleteTxnHandler(txnList[index].id);
                        },
                      ),
                    ),
                  );
                },
                itemCount: txnList.length,
              ),
      ),
    );
  }
}
