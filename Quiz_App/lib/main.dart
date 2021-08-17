import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;
  static const questions = [
    {
      'question': 'What\'s Your Favorite Color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Blue', 'score': 3},
        {'text': 'White', 'score': 1}
      ],
    },
    {
      'question': 'What\'s Your Favorite Animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Cat', 'score': 5},
        {'text': 'Elephant', 'score': 3},
        {'text': 'Lion', 'score': 0}
      ],
    },
    {
      'question': 'What\'s Your Favorite Football Team?',
      'answers': [
        {'text': 'Dortmund', 'score': 1},
        {'text': 'MU', 'score': 10},
        {'text': 'City', 'score': 5},
        {'text': 'Barcelona', 'score': 3}
      ],
    },
  ];

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First Flutter App'),
        ),
        // ini if statement
        body: _questionIndex < questions.length
            ? Quiz(_answerQuestion, questions, _questionIndex)
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
