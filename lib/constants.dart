import 'package:flutter/material.dart';

const kBoxColor = Color(0xFF1D1E33);

const kHeightKey = 'height';
const kWeightKey = 'weight';

class AppTextStyles {
  static const labelTextStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF8D8E98),
  );

  static const numberTextStyle = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w900,
  );

  static const titleTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: kBoxColor,
  );

  static const resultTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const bMITextStyle = TextStyle(
    fontSize: 75,
    fontWeight: FontWeight.bold,
  );

  static const bodyTextStyle = TextStyle(fontSize: 18);
}
