import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  BuildContext context;
  final int _questionCount = 10;
  final String difficulty;
  final String _type = 'boolean';
  List? questions;

  int currectScore = 0;

  int _questionNumberIndex = 0;
  GamePageProvider({required this.context, required this.difficulty}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    print(difficulty);
    try {
      final response = await _dio.get(
        '',
        queryParameters: {
          'amount': _questionCount,
          'difficulty': difficulty.toLowerCase(),
          'type': _type,
        },
      );

      // Use response.data directly (already parsed JSON)
      final data = response.data;

      // Check API response code (OpenTDB returns 0 for success)
      if (data['response_code'] == 0) {
        questions = data['results'];
        notifyListeners();
        print(questions); // or handle them as needed
      } else {
        throw Exception('API returned an error: ${data['response_code']}');
      }
    } catch (e) {
      print('Error fetching questions: $e');
      throw Exception('Failed to fetch questions');
    }
  }

  String currentQuestionCount() {
    return questions![_questionNumberIndex]['question'];
  }

  void answerQuestion(String answer) async {
    bool isCorrect =
        questions![_questionNumberIndex]['correct_answer'] == answer;
    print(isCorrect ? 'Correct' : 'Incorrect');

    if (isCorrect) {
      currectScore++;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (BuildContext context) => AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check : Icons.clear,
              color: Colors.white,
            ),
          ),
    );

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if (_questionNumberIndex == questions!.length - 1)
      endGame();
    else
      nextQuestion();
  }

  void nextQuestion() {
    _questionNumberIndex++;
    notifyListeners();
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.blue,
            title: Text(
              'Game Over',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            content: Text(
              "SCORE: $currectScore/$_questionCount",
              style: TextStyle(color: Colors.white),
            ),
          ),
    );

    await Future.delayed(Duration(seconds: 5));
    Navigator.pop(context);
    Navigator.pop(context);
    _questionNumberIndex = 0;
  }
}
