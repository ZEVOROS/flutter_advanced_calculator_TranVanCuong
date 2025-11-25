import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';

class ModeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _item(context, 'Basic', CalculatorMode.basic, calc.mode),
        const SizedBox(width: 8),
        _item(context, 'Scientific', CalculatorMode.scientific, calc.mode),
        const SizedBox(width: 8),
        _item(context, 'Programmer', CalculatorMode.programmer, calc.mode),
      ],
    );
  }

  Widget _item(BuildContext context, String label, CalculatorMode value, CalculatorMode current) {
    final selected = value == current;
    return GestureDetector(
      onTap: () => Provider.of<CalculatorProvider>(context, listen: false).setMode(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.tertiary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(label, style: TextStyle(color: selected ? Colors.white : Theme.of(context).textTheme.labelLarge!.color, fontSize: 16)),
      ),
    );
  }
}
