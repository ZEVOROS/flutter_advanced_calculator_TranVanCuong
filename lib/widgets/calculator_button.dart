import 'package:flutter/material.dart';
import '../constants.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  final double? fontSize;

  const CalculatorButton({Key? key, required this.label, this.onTap, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppLayout.buttonRadius)),
      ),
      child: Text(label, style: TextStyle(fontSize: fontSize ?? 16)),
    );
  }
}
