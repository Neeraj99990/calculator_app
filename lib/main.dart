import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  double _currentValue = 0;
  double _previousValue = 0;
  String _operator = '';
  String _operatorClicked = '';

  void _buttonPressed(String buttonText) {
    if (buttonText == 'AC') {
      _display = '0';
      _currentValue = 0;
      _previousValue = 0;
      _operator = '';
      _operatorClicked = '';
    } else if (buttonText == '+/-') {
      _currentValue = _currentValue * -1;
    } else if (buttonText == '.' ||
        buttonText == '0' ||
        buttonText == '1' ||
        buttonText == '2' ||
        buttonText == '3' ||
        buttonText == '4' ||
        buttonText == '5' ||
        buttonText == '6' ||
        buttonText == '7' ||
        buttonText == '8' ||
        buttonText == '9') {
      if (_display == '0' || _operatorClicked == '=') {
        _display = buttonText;
      } else {
        _display = _display + buttonText;
      }
      _currentValue = double.parse(_display);
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/') {
      _operator = buttonText;
      _operatorClicked = buttonText;
      _previousValue = _currentValue;
      _display = _display + _operator;
    } else if (buttonText == '=') {
      if (_operatorClicked == '+') {
        _currentValue = _previousValue + _currentValue;
      } else if (_operatorClicked == '-') {
        _currentValue = _previousValue - _currentValue;
      } else if (_operatorClicked == '*') {
        _currentValue = _previousValue * _currentValue;
      } else if (_operatorClicked == '/') {
        _currentValue = _previousValue / _currentValue;
      }
      _display = _currentValue.toString();
      _operatorClicked = '=';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              _display,
              style: TextStyle(fontSize: 48),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              _buildButtonRow('7', '8', '9', '/'),
              _buildButtonRow('4', '5', '6', '*'),
              _buildButtonRow('1', '2', '3', '-'),
              _buildButtonRow('0', '.', 'AC', '+'),
              _buildButtonRow('', '', '+/-', '='),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      String buttonText, Color buttonColor, VoidCallback onPressed) {
    return Expanded(
      child: MaterialButton(
        color: buttonColor,
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildButtonRow(String buttonText1, String buttonText2,
      String buttonText3, String buttonText4) {
    return Row(
      children: [
        _buildButton(buttonText1, Colors.blue, () => _buttonPressed(buttonText1)),
        _buildButton(buttonText2, Colors.blue, () => _buttonPressed(buttonText2)),
        _buildButton(buttonText3, Color.fromARGB(255, 247, 0, 0), () => _buttonPressed(buttonText3)),
        _buildButton(buttonText4, Color.fromARGB(255, 29, 28, 27), () => _buttonPressed(buttonText4)),
      ],
    );
  }
}