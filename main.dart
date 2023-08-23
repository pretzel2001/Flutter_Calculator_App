import 'package:flutter/material.dart';

import 'Calculator.dart';

const Color primaryColor = Color(0xff0E283A);
const Color secondaryColor = Color(0xff0B334E);
const Color equalColor = Color(0xff56a7c5);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor
      ),
      home: const Calculator(),
    );
  }
}