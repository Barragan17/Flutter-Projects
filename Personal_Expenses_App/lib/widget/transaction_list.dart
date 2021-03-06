import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List _userTransaction;
  final Function _deleteTransactions;

  TransactionList(this._userTransaction, this._deleteTransactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _userTransaction.isEmpty
          // use layout builder to set the height dynamincally according to the widget's custom height
          ? LayoutBuilder(builder: (ctx, constraint) {
              return Column(
                children: [
                  Text(
                    'No Transaction Added Yet',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: Image.asset(
                      'assets/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  // ListTile to create a list item easily without having to configure it using row or column
                  child: ListTile(
                    // if you want to create a circle avatar using container
                    // use decoration property and use BoxDecoration and use shape

                    // Container(
                    //   height: 60,
                    //   width: 60,
                    //   decoration: BoxDecoration(
                    //     color: Theme.of(context).primaryColor,
                    //     shape: BoxShape.circle
                    //   ),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              'Rp ${_userTransaction[index].amount.toStringAsFixed(0)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      _userTransaction[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(_userTransaction[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? FlatButton.icon(
                            onPressed: () =>
                                _deleteTransactions(_userTransaction[index].id),
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () =>
                                _deleteTransactions(_userTransaction[index].id),
                          ),
                  ),
                );
                // return Card(
                //   child: Row(
                //     children: [
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //           vertical: 10,
                //           horizontal: 15,
                //         ),
                //         width: 80,
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Theme.of(context).primaryColor,
                //             width: 2,
                //           ),
                //         ),
                //         padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                //         child: Text(
                //           // String Interpolation
                //           'Rp${_userTransaction[index].amount.toStringAsFixed(0)}',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 10,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //           textAlign: TextAlign.center,
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             _userTransaction[index].title,
                //             style: Theme.of(context).textTheme.title,
                //           ),
                //           Text(
                //             DateFormat.yMMMMd()
                //                 .format(_userTransaction[index].date),
                //             style: TextStyle(
                //               color: Colors.grey,
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: _userTransaction.length,
            ),
    );
  }
}
