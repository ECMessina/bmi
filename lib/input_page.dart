import 'package:bmi/calculator.dart';
import 'package:bmi/constants.dart';
import 'package:bmi/up_down_save_button.dart';
import 'package:bmi/info_box.dart';
import 'package:bmi/results.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  DateTime date = DateTime.now();
  late int height;
  late int heightFeet;
  late int heightInches;
  late int weight;
  bool _loading = true;
  late String bmiResult;
  late String resultText;
  late String interpretation;
  late Color resultTextColor;
  late SharedPreferences prefs;

  late SliderThemeData sliderThemeData = SliderTheme.of(context).copyWith(
    inactiveTrackColor: const Color(0xFF8D8E98),
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 13.0),
    thumbColor: const Color(0xFFEB1555),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
    overlayColor: const Color(0x29EB1555),
  );

  String get formattedDate => DateFormat('MM-dd-yyyy').format(date);

  @override
  void initState() {
    super.initState();
    initializeValues();
  }

  Future<void> initializeValues() async {
    prefs = await SharedPreferences.getInstance();

    height = prefs.getInt(kHeightKey) ?? 60;
    calculateHeight();

    weight = prefs.getInt(kWeightKey) ?? 120;

    calcResultsInfo();

    setState(() {
      _loading = false;
    });
  }

  void calcResultsInfo() {
    Calculator calc = Calculator(height: height, weight: weight);
    bmiResult = calc.brainResult.bmiString;
    resultText = calc.brainResult.result;
    interpretation = calc.brainResult.interpretation;
    resultTextColor = calc.brainResult.color;
    sliderThemeData = sliderThemeData.copyWith(
      activeTrackColor: resultTextColor,
    );
  }

  void calculateHeight() {
    heightFeet = (height / 12).truncate();
    heightInches = height % 12;
  }

  List<Color> generateColorGradientForWeightRange(
    int minWeight,
    int maxWeight,
    int height,
  ) {
    List<Color> colors = [];
    for (int weight = minWeight; weight <= maxWeight; weight++) {
      Calculator calc = Calculator(height: height, weight: weight);

      colors.add(calc.brainResult.color);
    }
    return colors;
  }

  Widget buildGradientTrack(int height, int minWeight, int maxWeight) {
    List<Color> gradientColors = generateColorGradientForWeightRange(
      minWeight,
      maxWeight,
      height,
    );

    return Center(
      child: Container(
        height: 4,
        width: MediaQuery.sizeOf(context).width - 90,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
          child: SizedBox(
            height: 75,
            width: 75,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              color: Color(0xFFEB1555),
            ),
          ),
        )
        : SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFEB1555),
              title: const Center(
                child: Text(
                  'Calculate your BMI:',
                  style: AppTextStyles.titleTextStyle,
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InfoBox(
                        createdColor: kBoxColor,
                        containerChild: Text(
                          'User',
                          style: AppTextStyles.textTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        onTapFunction: () {},
                      ),
                    ),
                    Expanded(
                      child: InfoBox(
                        createdColor: kBoxColor,
                        containerChild: Text(
                          formattedDate,
                          style: AppTextStyles.textTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        onTapFunction: () {},
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: InfoBox(
                    createdColor: kBoxColor,
                    containerChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'HEIGHT',
                          style: AppTextStyles.labelTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5,
                          children: [
                            UpDownSaveButton(
                              onPressed: () async {
                                setState(() {
                                  if (heightInches > 0) {
                                    heightInches--;
                                  } else if (heightFeet > 0) {
                                    heightFeet--;
                                    heightInches = 11;
                                  }
                                  height = heightFeet * 12 + heightInches;
                                  calculateHeight();
                                  calcResultsInfo();
                                });
                                await prefs.setInt(kHeightKey, height);
                              },
                              icon: Icons.remove,
                              iconColor: Colors.red,
                            ),
                            Text(
                              '$heightFeet\' $heightInches"',
                              style: AppTextStyles.numberTextStyle,
                            ),
                            UpDownSaveButton(
                              onPressed: () async {
                                setState(() {
                                  if (heightInches < 11) {
                                    heightInches++;
                                  } else {
                                    heightFeet++;
                                    heightInches = 0;
                                  }
                                  height = heightFeet * 12 + heightInches;
                                  calculateHeight();
                                  calcResultsInfo();
                                });
                                await prefs.setInt(kHeightKey, height);
                              },
                              icon: Icons.add,
                              iconColor: Color(0xFF24D876),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InfoBox(
                    createdColor: kBoxColor,
                    containerChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'WEIGHT',
                          style: AppTextStyles.labelTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            UpDownSaveButton(
                              onPressed: () async {
                                setState(() {
                                  if (weight > 80) {
                                    weight--;
                                    calcResultsInfo();
                                  }
                                });
                                await prefs.setInt(kWeightKey, weight);
                              },
                              icon: Icons.remove,
                              iconColor: Colors.red,
                            ),
                            Text(
                              weight.toString(),
                              style: AppTextStyles.numberTextStyle,
                            ),
                            const Text(
                              'lbs',
                              style: AppTextStyles.labelTextStyle,
                            ),
                            UpDownSaveButton(
                              onPressed: () async {
                                setState(() {
                                  if (weight < 250) {
                                    weight++;
                                    calcResultsInfo();
                                  }
                                });
                                await prefs.setInt(kWeightKey, weight);
                              },
                              icon: Icons.add,
                              iconColor: Color(0xFF24D876),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            buildGradientTrack(height, 80, 250),
                            SliderTheme(
                              data: sliderThemeData,
                              child: Slider(
                                value: weight.toDouble(),
                                min: 80,
                                max: 250,
                                onChanged: (double newValue) async {
                                  setState(() {
                                    weight = newValue.round();
                                    calcResultsInfo();
                                  });
                                  await prefs.setInt(kWeightKey, weight);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InfoBox(
                    createdColor: kBoxColor,
                    containerChild: Results(
                      bmiResult: bmiResult,
                      resultText: resultText,
                      interpretation: interpretation,
                      resultTextColor: resultTextColor,
                    ),
                  ),
                ),
                InfoBox(
                  createdColor: kBoxColor,
                  containerChild: UpDownSaveButton(
                    onPressed: () {},
                    icon: Icons.save,
                    iconColor: Color(0xFFEB1555),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
