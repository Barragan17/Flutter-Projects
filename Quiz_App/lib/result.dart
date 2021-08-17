import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  Result(this.resultScore, this.resetHandler);

  String get resultPhase {
    String textResult;
    if (resultScore <= 8) {
      textResult = 'You are Awesome and Innocent';
    } else if (resultScore <= 12) {
      textResult = 'You are pretty likeable';
    } else if (resultScore <= 16) {
      textResult = 'You are ... Strange';
    } else {
      textResult = 'You are so bad';
    }
    return textResult;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: resetHandler,
            child: Text('Restart Quiz'),
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
