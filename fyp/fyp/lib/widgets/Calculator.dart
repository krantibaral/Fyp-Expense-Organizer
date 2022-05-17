import 'package:flutter/material.dart';

import 'calculator_button.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _SIForm createState() => _SIForm();
}

class _SIForm extends State<Calculator> {
  late int firstNum;
  late int secondNum;
  late String history = "";
  late String textToDisplay = "";
  late String res;
  late String operations;

  void btnOnClick(String btnVal) {
    print(btnVal);
    if (btnVal == "C") {
      textToDisplay = "";
      firstNum = 0;
      secondNum = 0;
      res = "";
    } else if (btnVal == "AC") {
      textToDisplay = "";
      firstNum = 0;
      secondNum = 0;
      res = "";
      history = "";
    } else if (btnVal == "Del") {
      res = textToDisplay.substring(0, textToDisplay.length - 1);
    } else if (btnVal == "+" ||
        btnVal == "-" ||
        btnVal == "/" ||
        btnVal == "X") {
      firstNum = int.parse(textToDisplay);
      res = "";
      operations = btnVal;
    } else if (btnVal == "=") {
      secondNum = int.parse(textToDisplay);
      if (operations == '+') {
        res = (firstNum + secondNum).toString();
        history =
            firstNum.toString() + operations.toString() + secondNum.toString();
      }
      if (operations == '-') {
        res = (firstNum - secondNum).toString();
        history =
            firstNum.toString() + operations.toString() + secondNum.toString();
      }
      if (operations == '/') {
        res = (firstNum / secondNum).toString();
        history =
            firstNum.toString() + operations.toString() + secondNum.toString();
      }
      if (operations == 'X') {
        res = (firstNum * secondNum).toString();
        history =
            firstNum.toString() + operations.toString() + secondNum.toString();
      }
    } else {
      res = int.parse(textToDisplay + btnVal).toString();
    }
    setState(() {
      textToDisplay = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Calculator",
            style: TextStyle(fontFamily: "Roboto Condensed", fontSize: 24),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    // begin: Alignment.topCenter,
                    // end: Alignment.bottomCenter,
                    colors: [
                  // Color(0x665ac18e),
                  Color(0x995ac18e),
                  Color(0xcc5ac18e),
                  Color(0xff5ac18e),
                ])),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0x665ac18e),
                  Color(0x995ac18e),
                  Color(0xcc5ac18e),
                  Color(0xff5ac18e),
                ])),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    history,
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  ),
                ),
                alignment: Alignment(1.0, 1.0),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    textToDisplay,
                    style: TextStyle(fontSize: 48, color: Colors.black),
                  ),
                ),
                alignment: Alignment(1.0, 1.0),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                CalculatorButton(
                  text: "AC",
                  fillColor: 0xfff4d160,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "C",
                  fillColor: 0xfff4d160,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "Del",
                  fillColor: 0xfff4d160,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "/",
                  fillColor: 0xfff4d160,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                CalculatorButton(
                  text: "9",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "8",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "7",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "X",
                  fillColor: 0xfff4d160,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                CalculatorButton(
                  text: "6",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "5",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "4",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "-",
                  fillColor: 0xfff4d160,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                CalculatorButton(
                  text: "3",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "2",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "1",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "+",
                  fillColor: 0xfff4d160,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                CalculatorButton(
                  text: "0",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "00",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "000",
                  fillColor: 0xffA9A9A9,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: "=",
                  fillColor: 0xfff4d160,
                  textColor: 0xff000000,
                  textSize: 20,
                  callback: btnOnClick,
                ),
              ]),
            ])));
  }
}
