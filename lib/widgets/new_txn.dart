import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTxn extends StatefulWidget {
  final Function newTxnHandler;

  NewTxn(this.newTxnHandler);

  @override
  _NewTxnState createState() => _NewTxnState();
}

class _NewTxnState extends State<NewTxn> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if(value == null){
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }

  void addTxn() {
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.newTxnHandler(enteredTitle, enteredAmount, selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            Container(
              height: 60,
              child: Row(
                children: <Widget>[
                  Text(selectedDate == null ? 'No Date Chosen!' : DateFormat.yMd().format(selectedDate)),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Submit Expense',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: addTxn,
            )
          ],
        ),
      ),
    );
  }
}
