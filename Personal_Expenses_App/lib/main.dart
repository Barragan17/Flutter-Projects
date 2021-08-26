import 'package:Personal_Expenses_App/widget/chart.dart';
import 'package:Personal_Expenses_App/widget/new_transaction.dart';
import 'package:Personal_Expenses_App/widget/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './model/transaction.dart';

void main() {
  // Use this line to restrict landscape mode

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses App',
      theme: ThemeData(
        primaryColor: Colors.yellow,
        accentColor: Colors.indigo,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // late String titleInput;
  // late String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 10000,
      date: DateTime.now(),
    ),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 100000,
        date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    // List<Transaction> recentTransactions = [];
    // for (var i = 0; i < _userTransaction.length; i++) {
    //   if (_userTransaction[i].date.isAfter(
    //         DateTime.now().subtract(
    //           Duration(days: 7),
    //         ),
    //       )) {
    //     recentTransactions.add(_userTransaction[i]);
    //   }
    // }
    // return recentTransactions;
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _switchStatus = false;

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime transactionsDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: transactionsDate,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransactions(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses App'),
      actions: [
        IconButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // use this line to set the height dynamically according to the phone's size
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(
                  value: _switchStatus,
                  onChanged: (val) {
                    setState(() {
                      _switchStatus = val;
                    });
                  },
                ),
              ],
            ),
            // use if statement to set which content to be shown
            _switchStatus
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.7 -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top,
                    child: Chart(_recentTransactions),
                  )
                // set the height amount to 1.0 in total
                : Container(
                    height: MediaQuery.of(context).size.height * 0.75 -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top,
                    child:
                        TransactionList(_userTransaction, _deleteTransactions)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
