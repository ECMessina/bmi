import 'package:flutter/material.dart';
import 'dart:math';

class Calculator {
  Calculator({required this.height, required this.weight}) {
    _calculateBMI();
    brainResult = CalculatorBrainResult(bmi: _bmi);
  }

  final int height;
  final int weight;
  late CalculatorBrainResult brainResult;
  late double _bmi;

  void _calculateBMI() {
    _bmi = ((weight / pow(height, 2)) * 703);
  }

  String getBMI() {
    return _bmi.toStringAsFixed(1);
  }
}

class CalculatorBrainResult {
  CalculatorBrainResult({required bmi}) : _bmi = bmi {
    getValues();
  }

  final double _bmi;

  late String bmiString;
  late String result;
  late Color color;
  late String interpretation;

  void getValues() {
    bmiString = _bmi.toStringAsFixed(1);

    if (_bmi >= 30) {
      result = 'Obese';
      color = Colors.red;
      interpretation =
          'You are at risk of developing serious health problems due to excess weight. Please seek a health professional to help.';
    } else if (_bmi > 25) {
      result = 'Overweight';
      color = Colors.orange;
      interpretation =
          'You have a higher than normal body weight for your characteristics. Consider altering your diet and increasing your exercise program.';
    } else if (_bmi > 18.5) {
      result = 'Normal';
      color = const Color(0xFF24D876);
      interpretation = 'You are doing all the right things. Keep it up!';
    } else {
      result = 'Underweight';
      color = Colors.amber;
      interpretation =
          'You have a lower than normal body weight for your characteristics. Consider increasing your diet and modifying your exercise program.';
    }
  }
}
