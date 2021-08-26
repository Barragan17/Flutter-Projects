import 'dart:io';
import 'package:Personal_Expenses_App/widget/chart.dart';
import 'package:Personal_Expenses_App/widget/new_transaction.dart';
import 'package:Personal_Expenses_App/widget/transaction_list.dart';
import 'package:flutter/cupertino.dart';
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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        // use cupertino in order to set the ios app bar theme
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses App'),
            actions: [
              IconButton(
                onPressed: () {
                  _startAddNewTransaction(context);
                },
                icon: Icon(Icons.add),
              ),
            ],
          ) as PreferredSizeWidget;
    final transactionsList = Container(
      height: mediaQuery.size.height * 0.75 -
          appBar.preferredSize.height -
          mediaQuery.padding.top,
      child: TransactionList(_userTransaction, _deleteTransactions),
    );
    // use safe area to move the widget so that it didn't use the reserved space (in IOS)
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // use this line to set the height dynamically according to the phone's size
            // use if statement to set a different content based on it's orientation

            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.title,
                  ),
                  // use adaptive so it can change the switch based on the user plattform device
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _switchStatus,
                    onChanged: (val) {
                      setState(() {
                        _switchStatus = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: mediaQuery.size.height * 0.4 -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) transactionsList,
            // use if statement to set which content to be shown
            // also use if statement to change the content
            if (isLandscape)
              _switchStatus
                  ? Container(
                      height: mediaQuery.size.height * 0.7 -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top,
                      child: Chart(_recentTransactions),
                    )
                  // set the height amount to 1.0 in total
                  : transactionsList
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            // to check if the platform use ios
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                  ),
          );
  }
}
