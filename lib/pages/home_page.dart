import 'package:flutter/material.dart';
import 'package:friviaa/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  List<String> _categories = ["Easy", "Medium", "Hard"];
  String _selectedDifficulty = "Easy"; // Initially selected

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black, // To match white text
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _headerTextContent(_selectedDifficulty),
            _dropdownSelector(), // UI to change difficulty
            _startButton(),
          ],
        ),
      ),
    );
  }

  Widget _headerTextContent(String text) {
    return Column(
      children: [
        Text(
          "Friviaa",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _dropdownSelector() {
    return Slider(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.15),
      value: _categories.indexOf(_selectedDifficulty).toDouble(),
      min: 0,
      max: (_categories.length - 1).toDouble(),
      divisions: _categories.length - 1,
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
      label: _selectedDifficulty,
      onChanged: (double value) {
        setState(() {
          _selectedDifficulty = _categories[value.round()];
        });
      },
    );
  }

  Widget _startButton() {
    return MaterialButton(
      height: _deviceHeight! * 0.10,
      minWidth: _deviceWidth! * 0.80,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder:
                (context) => GamePage(
                  difficulty: _selectedDifficulty,
                  // questionCount: 10,
                  // type: "boolean",
                ),
          ),
        );
      },
      child: Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: _deviceHeight! * 0.04,
          fontWeight: FontWeight.w500,
        ),
      ),
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
