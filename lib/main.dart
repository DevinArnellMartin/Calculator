import 'package:flutter/material.dart';
//DEVIN MARTIN

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CalcScreen(),
    );
  }
}

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
   CalcState createState() => CalcState();
}

class CalcState extends State<CalcScreen> {
  String txt = "";
  double? first_operand;
  double? second_operand;
  String? operator;

  void buttonPress(String value) { // on button press do appropriate action
    if (value == "C") {
      clr();
    } else if (value == "=") {
      calc();
    } else {
      alterDisplay(value);
    }
  }

  void clr() {
    setState(() {
      txt = "";
      first_operand = null;
      second_operand = null;
      operator = null;
    });
  }

  void alterDisplay(String value) {
    setState(() {
      txt += value;
    });
  }

  void calc() {
    List<String> parts = txt.split(RegExp(r'([+\-*/])')); // works

    if (parts.length == 2) {
      first_operand = double.tryParse(parts[0]);
      operator = parts[1];
      second_operand = double.tryParse(parts[2]);

      if (second_operand != null && first_operand != null && operator != null) {
        double? res;

        switch (operator) {
          case "*":
            res = first_operand! * second_operand!;
            break;
          case "/":
            if (second_operand == 0) {
              txt = "ZeroDivisionError: Cannot divide by 0";
              return;
            }
            res = first_operand! / second_operand!;
            break;

          case "+":
            res = first_operand! + second_operand!;
            break;
          case "-":
            res = first_operand! - second_operand!;
            break;
          
        }

        setState(() {
          txt = res.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
            alignment: Alignment.centerRight,
            child: Text(
              txt,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              makeButton("7"),
              makeButton("8"),
              makeButton("9"),
              makeButton("/"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              makeButton("4"),
              makeButton("5"),
              makeButton("6"),
              makeButton("*"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              makeButton("-"),
              makeButton("1"),
              makeButton("2"),
              makeButton("3"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              makeButton("Clr"),
              makeButton("0"),
              makeButton("="),
              makeButton("+"),
            ],
          ),
        ],
      ),
    );
  }

  Widget makeButton(String val) {
    return ElevatedButton(
      onPressed: () => buttonPress(val),
      child: Text(val, style: const TextStyle(fontSize: 26)),
    );
  }
}
