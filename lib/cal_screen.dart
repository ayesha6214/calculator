import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";
  List<String> buttonList = [
    'ac',
    'ce',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: "Arimo",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    result,
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: "Arimo",
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(
              height: 15,
            ),
            Flexible(
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return customButton(buttonList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton(String text) {
    return InkWell(
      splashColor: const Color.fromARGB(10, 187, 193, 199),
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 0.5,
                offset: const Offset(-3, -3),
              ),
            ]),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Arimo",
            ),
          ),
        ),
      ),
    );
  }

  getBgColor(String text) {
    if (text == '/' ||
        text == '*' ||
        text == '-' ||
        text == '+' ||
        text == '=') {
      return const Color.fromARGB(255, 80, 14, 205);
    }
    if (text == 'ac' || text == 'ce' || text == '%') {
      return Colors.grey;
    }
    return const Color.fromARGB(255, 87, 79, 79);
  }

  void handleButtons(String text) {
    if (text == 'ac') {
      setState(() {
        userInput = "";
        result = "0";
      });
      return;
    }
    if (text == 'ce') {
      setState(() {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      });
      return;
    }
    if (text == '=') {
      setState(() {
        try {
          Parser p = Parser();
          Expression exp = p.parse(userInput);
          ContextModel cm = ContextModel();
          result = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          result = "Invalid Input";
        }
      });
      return;
    }
    setState(() {
      userInput += text;
    });
  }
}
