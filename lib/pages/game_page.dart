import 'package:flutter/material.dart';
import 'package:friviaa/providers/game_page.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  double? _deviceHeight, _deviceWidth;
  final String difficulty;
  GamePage({super.key, required String this.difficulty});
  GamePageProvider? _gamePageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<GamePageProvider>(
      create:
          (context) =>
              GamePageProvider(context: context, difficulty: difficulty),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (context) {
        _gamePageProvider = context.watch<GamePageProvider>();
        if (_gamePageProvider!.questions != null) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _deviceWidth! * 0.05,
                vertical: _deviceHeight! * 0.05,
              ),
              child: _gameUI(),
            ),
          );
        } else {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _deviceWidth! * 0.05,
                vertical: _deviceHeight! * 0.05,
              ),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }

  Widget _gameUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _questionText(),
          Column(
            children: [
              _trueButton(),
              SizedBox(height: _deviceHeight! * 0.02),
              _falseButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _questionText() {
    return Text(
      _gamePageProvider!.currentQuestionCount(),
      // question,
      style: TextStyle(
        fontSize: _deviceHeight! * 0.03,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }

  // regarding true/false buttons
  Widget _trueButton() {
    return MaterialButton(
      height: _deviceHeight! * 0.10,
      minWidth: _deviceWidth! * 0.80,
      onPressed: () {
        _gamePageProvider!.answerQuestion("True");
      },
      child: Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: _deviceHeight! * 0.02,
          fontWeight: FontWeight.w500,
        ),
      ),
      color: Colors.green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      height: _deviceHeight! * 0.10,
      minWidth: _deviceWidth! * 0.80,
      onPressed: () {
        _gamePageProvider!.answerQuestion("False");
      },
      child: Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: _deviceHeight! * 0.02,
          fontWeight: FontWeight.w500,
        ),
      ),
      color: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
