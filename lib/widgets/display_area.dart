import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../constants.dart';

class DisplayArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);
    return GestureDetector(
      onHorizontalDragEnd: (details) => calc.backspace(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(AppLayout.screenPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppLayout.displayRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(calc.expression, textAlign: TextAlign.right, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 8),
            AnimatedOpacity(
              opacity: 1,
              duration: const Duration(milliseconds: 300),
              child: Text(
                calc.error.isNotEmpty ? calc.error : calc.result,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: calc.error.isNotEmpty ? Colors.red : null),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(calc.angleIsDegrees ? 'DEG' : 'RAD', style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 12),
                if (calc.memoryValue != 0) const Text('M', style: TextStyle(fontSize: 12)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
