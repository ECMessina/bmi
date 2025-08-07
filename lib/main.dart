import 'package:bmi/input_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      home: const InputPage(),
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A0E21),
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
