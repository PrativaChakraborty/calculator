import 'dart:math';

import 'package:calculator/main.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var expression;
  String equation = '';
  String result = "";
  _isOperator(String s) {
    return s == '+' || s == '-' || s == '*' || s == '/' || s == '%';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  currentTheme.toggleTheme();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wb_sunny_outlined,
                        color: currentTheme.getThemeMode() == ThemeMode.light
                            ? Theme.of(context).canvasColor
                            : Colors.grey[700],
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Icon(Icons.nightlight_round,
                          color: currentTheme.getThemeMode() == ThemeMode.light
                              ? Colors.grey[300]
                              : Theme.of(context).canvasColor),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    equation.toString(),
                    style: numberFont.copyWith(
                        color: Theme.of(context).canvasColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    result.toString(),
                    style: TextStyle(
                        fontSize: 60, color: Theme.of(context).canvasColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              //  height: MediaQuery.of(context).size.height * 0.65,
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor, //secondaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: GridView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                children: [
                  _buildCell(
                    "C",
                    color: blue,
                    isSpecial: true,
                    ontap: () {
                      equation = equation.substring(0, equation.length - 1);
                    },
                  ),
                  _buildCell("π", color: blue, isSpecial: true, ontap: () {
                    if (_isOperator(equation[equation.length - 1])) {
                      equation += 'π';
                    } else {
                      equation += '*π';
                    }
                  }),
                  _buildCell(
                    "%",
                    color: blue,
                    isSpecial: true,
                    ontap: () {
                      if (_isOperator(equation[equation.length - 1])) {
                      } else {
                        equation += "%";
                      }
                    },
                  ),
                  _buildCell("÷", color: orange, isSpecial: true, ontap: () {
                    if (_isOperator(equation[equation.length - 1])) {
                      equation =
                          equation.substring(0, equation.length - 1) + "/";
                    } else {
                      equation += "/";
                    }
                  }),
                  _buildCell("7"),
                  _buildCell("8"),
                  _buildCell("9"),
                  _buildCell("x", color: orange, isSpecial: true, ontap: () {
                    if (_isOperator(equation[equation.length - 1])) {
                      equation =
                          equation.substring(0, equation.length - 1) + "*";
                    } else {
                      equation += "*";
                    }
                  }),
                  _buildCell("4"),
                  _buildCell("5"),
                  _buildCell("6"),
                  _buildCell("-", color: orange, isSpecial: true, ontap: () {
                    if (_isOperator(equation[equation.length - 1])) {
                      equation =
                          equation.substring(0, equation.length - 1) + "-";
                    } else {
                      equation += "-";
                    }
                  }),
                  _buildCell("1"),
                  _buildCell("2"),
                  _buildCell("3"),
                  _buildCell("+", color: orange, isSpecial: true, ontap: () {
                    if (_isOperator(equation[equation.length - 1])) {
                      equation =
                          equation.substring(0, equation.length - 1) + "+";
                    } else {
                      equation += "+";
                    }
                  }),
                  _buildCell("a", icon: Icons.replay_outlined, isSpecial: true,
                      ontap: () {
                    setState(() {
                      equation = '';
                      result = '';
                    });
                  }),
                  _buildCell("0"),
                  _buildCell("."),
                  _buildCell("=", color: orange, isSpecial: true, ontap: () {
                    Parser p = Parser();
                    print(equation);
                    equation = equation[equation.length - 1] == "%"
                        ? equation.substring(0, equation.length - 1) + "/100"
                        : equation;
                    Expression exp = p.parse(equation);
                    exp.simplify();
                    print(equation);
                    print(exp.toString());
                    ContextModel cm = ContextModel();
                    cm.bindVariable(Variable("π"), Number(pi));
                    double eval = exp.evaluate(EvaluationType.REAL, cm);
                    print(eval);
                    // result = double.parse(eval.toStringAsFixed(4))
                    //     .
                    //     .toString();
                    result = eval.toString().length >= 10
                        ? eval.toString().substring(0, 10)
                        : eval.toString();
                    // expression = Expression.parse(equation);
                    // // var context = {'π': pi,'%':};
                    // final evaluator = const ExpressionEvaluator();
                    // result = evaluator.eval(expression, context).toString();

                    setState(() {});
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String text,
      {Color color, IconData icon, Function ontap, bool isSpecial = false}) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  color: Theme.of(context).canvasColor,
                )
              : Text(text,
                  style: color == null
                      ? numberFont.copyWith(
                          fontSize: 30, color: Theme.of(context).canvasColor)
                      : numberFont.copyWith(
                          color: color,
                          fontSize: 30,
                        )),
        ),
      ),
      onTap: () {
        if (isSpecial) {
          ontap();
        } else {
          equation += text;
        }
        setState(() {});
      },
    );
  }
}

Color orange = Color(0xffBF595B);
Color blue = Color(0xff26EBC8);
TextStyle numberFont = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
