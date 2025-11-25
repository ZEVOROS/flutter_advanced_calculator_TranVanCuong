import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';
import '../constants.dart';
import 'calculator_button.dart';

class ButtonGrid extends StatefulWidget {
  @override
  _ButtonGridState createState() => _ButtonGridState();
}

class _ButtonGridState extends State<ButtonGrid> {
  String _pressedKey = '';

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);
    final mode = calc.mode;

    List<String> buttons;
    int crossAxis;

    if (mode == CalculatorMode.scientific) {
      crossAxis = 6;
      buttons = [
        '2nd','sin','cos','tan','ln','log',
        'x²','√','^','(',')','÷',
        'MC','7','8','9','C','×',
        'MR','4','5','6','CE','-',
        'M+','1','2','3','%','+',
        'M-','±','0','.','π','='
      ];
    } else if (mode == CalculatorMode.programmer) {
      crossAxis = 6;
      buttons = [
        'BIN','OCT','DEC','HEX','<<','>>',
        'AND','OR','XOR','NOT','C','CE',
        '0xFF','0x0F','A','B','C','D',
        'E','F','&','|','^','~',
        '<<1','>>1','+','-','*','/',
        '(',')','%','=','MR','MC'
      ];
    } else {
      crossAxis = 4;
      buttons = [
        'C','CE','%','÷',
        '7','8','9','×',
        '4','5','6','-',
        '1','2','3','+',
        '±','0','.','='
      ];
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppLayout.buttonSpacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxis,
        crossAxisSpacing: AppLayout.buttonSpacing,
        mainAxisSpacing: AppLayout.buttonSpacing,
        childAspectRatio: 1.0,
      ),
      itemCount: buttons.length,
      itemBuilder: (_, i) {
        final t = buttons[i];
        final isPressed = _pressedKey == t;

        return GestureDetector(
          onTapDown: (_) => setState(() => _pressedKey = t),
          onTapUp: (_) {
            setState(() => _pressedKey = '');
            _onPressed(t, calc);
          },
          onTapCancel: () => setState(() => _pressedKey = ''),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: isPressed ? 0.95 : 1.0,
            child: CalculatorButton(
              label: t,
              onTap: () => _onPressed(t, calc),
            ),
          ),
        );
      },
    );
  }

  void _onPressed(String t, CalculatorProvider calc) {
    if (t == 'C') calc.clear();
    else if (t == 'CE') calc.backspace();
    else if (t == '=') calc.evaluate();
    else if (t == 'π') calc.append('π');
    else if (t == 'MR') calc.memoryRecall();
    else if (t == 'MC') calc.memoryClear();
    else if (t == 'M+') {
      try {
        final val = double.parse(calc.result);
        calc.memoryAdd(val);
      } catch (_) {}
    }
    else if (t == 'M-') {
      try {
        final val = double.parse(calc.result);
        calc.memoryAdd(-val);
      } catch (_) {}
    }
    else if (t == '±') {
      if (calc.expression.startsWith('-')) {
        calc.expression = calc.expression.substring(1);
      } else {
        calc.expression = '-' + calc.expression;
      }
      calc.notifyListeners();
    }
    else {
      calc.append(
        t.replaceAll('×', '*').replaceAll('÷', '/')
      );
    }
  }
}
