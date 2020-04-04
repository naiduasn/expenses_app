import './widgets/chart.dart';
import './widgets/new_txn.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'OpenSans'),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final List<Transaction> userTransactionList = [
    // Transaction(
    //     id: '1', title: 'Eat out', amount: 250.00, date: DateTime.now()),
    // Transaction(
    //     id: '2', title: 'Shopping', amount: 950.00, date: DateTime.now()),
    //     Transaction(
    //     id: '3', title: 'Shopping', amount: 50.00, date: DateTime.now()),
    //     Transaction(
    //     id: '4', title: 'Shopping', amount: 1950.00, date: DateTime.now()),
    //     Transaction(
    //     id: '5', title: 'Shopping', amount: 50.00, date: DateTime.now()),
    //     Transaction(
    //     id: '6', title: 'Shopping', amount: 750.00, date: DateTime.now()),
    //     Transaction(
    //     id: '7', title: 'Shopping', amount: 500.00, date: DateTime.now()),
  ];
  List<Transaction> get _recentTxn {
    return userTransactionList.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTxn(String title, double amount, DateTime selectedDate) {
    final newTxn = Transaction(
        amount: amount,
        date: selectedDate,
        title: title,
        id: DateTime.now().toString());
    setState(() {
      userTransactionList.add(newTxn);
    });
  }

  void _deleteTxn(String id) {
    setState(() {
      userTransactionList.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void actionNewTxn(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return NewTxn(_addTxn);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              actionNewTxn(context);
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Chart(_recentTxn),
          TransactionList(userTransactionList, _deleteTxn),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          actionNewTxn(context);
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
