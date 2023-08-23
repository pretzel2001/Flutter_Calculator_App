import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'main.dart';

const Color primaryColor = Color(0xff0E283A);
const Color secondaryColor = Color(0xff0B334E);
const Color equalColor = Color(0xff296d98);

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";
  List<String> buttonList = [
    '(', ')', '%', '*', '1', '2', '3', '-', '4', '5', '6', '+', '7', '8', '9', '/', '0', '.', 'AC', '='
  ];

  void handleButtons(String text) {
    setState(() {
      if (text == "AC") {
        userInput = "";
        result = "0";
      } else if (text == "=") {
        try {
          result = _calculate(userInput);
        } catch (e) {
          result = "Error";
        }
      } else if (text == "%") {
        if (userInput.isNotEmpty && !userInput.contains("%")) {
          userInput += text;
        }
      } else {
        userInput += text;
      }
    });
  }


  String _calculate(String expression) {
    try {
      expression = expression.replaceAll('%', '/100'); // Convert percentages to fractions
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return "Error";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Calculator")),
        backgroundColor: secondaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 30, left: 0, right: 20, bottom: 20),
              color: secondaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ),
                  Text(
                    result,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: buttonList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => handleButtons(buttonList[index]),
                  child: Container(
                    decoration: BoxDecoration(
                      color: getBgColor(buttonList[index]),
                    ),
                    child: Center(
                      child: Text(
                        buttonList[index],
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: getColor(buttonList[index]),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  getColor(String text) {
    if (text == '=') {
      return Colors.white;
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == '=') {
      return equalColor;
    }
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Calculator(),
  ));
}
