import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({
    super.key,
    required this.createdColor,
    this.containerChild,
    this.onTapFunction,
  });

  final Color createdColor;
  final Widget? containerChild;
  final Function()? onTapFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: createdColor,
        ),
        child: containerChild,
      ),
    );
  }
}
