import 'package:bmi/constants.dart';
import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  const Results({
    super.key,
    required this.bmiResult,
    required this.resultText,
    required this.interpretation,
    required this.resultTextColor,
  });

  final String bmiResult;
  final String resultText;
  final String interpretation;
  final Color resultTextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          resultText.toUpperCase(),
          style: AppTextStyles.resultTextStyle.copyWith(color: resultTextColor),
        ),
        Text(bmiResult, style: AppTextStyles.bMITextStyle),
        Text(
          interpretation,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyTextStyle,
        ),
      ],
    );
  }
}
