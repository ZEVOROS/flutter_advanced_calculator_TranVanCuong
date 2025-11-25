import 'package:flutter/material.dart';
import '../models/calculation_history.dart';
import '../models/calculator_mode.dart';
import '../services/storage_service.dart';
import '../utils/calculator_logic.dart';

class CalculatorProvider extends ChangeNotifier {
  String expression = '';
  String result = '';
  String error = '';
  CalculatorMode mode = CalculatorMode.scientific;
  bool angleIsDegrees = true;
  double memoryValue = 0.0;
  List<CalculationHistory> history = [];
  final StorageService _storage = StorageService();

  CalculatorProvider() {
    _load();
  }

  void setMode(CalculatorMode m) {
    mode = m;
    notifyListeners();
    _save();
  }

  void append(String s) {
    expression += s;
    notifyListeners();
  }

  void clear() {
    expression = '';
    result = '';
    error = '';
    notifyListeners();
  }

  void backspace() {
    if (expression.isNotEmpty) expression = expression.substring(0, expression.length - 1);
    notifyListeners();
  }

  void evaluate() {
    try {
      final r = CalculatorLogic.evaluateExpression(expression, deg: angleIsDegrees);
      result = r;
      error = '';
      _addHistory(expression, result);
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
    _save();
  }

  void toggleAngleMode() {
    angleIsDegrees = !angleIsDegrees;
    notifyListeners();
    _save();
  }

  void memoryAdd(double v) {
    memoryValue += v;
    notifyListeners();
    _save();
  }

  void memoryClear() {
    memoryValue = 0.0;
    notifyListeners();
    _save();
  }

  void memoryRecall() {
    expression += memoryValue.toString();
    notifyListeners();
  }

  void _addHistory(String expr, String res) {
    final h = CalculationHistory(timestamp: DateTime.now(), expression: expr, result: res);
    history.insert(0, h);
    if (history.length > 50) history = history.sublist(0, 50);
    _storage.saveHistory(history);
    notifyListeners();
  }

  Future<void> _save() async {
    await _storage.saveSettings({
      'angleIsDegrees': angleIsDegrees,
      'memoryValue': memoryValue,
      'mode': mode.toString(),
    });
  }

  Future<void> _load() async {
    final loaded = await _storage.loadHistory();
    history = loaded;
    final s = await _storage.loadSettings();
    if (s != null) {
      angleIsDegrees = s['angleIsDegrees'] as bool? ?? angleIsDegrees;
      memoryValue = (s['memoryValue'] as num?)?.toDouble() ?? memoryValue;
      final m = s['mode'] as String?;
      if (m != null && m.contains('basic')) mode = CalculatorMode.basic;
      else if (m != null && m.contains('programmer')) mode = CalculatorMode.programmer;
      else mode = CalculatorMode.scientific;
    }
    notifyListeners();
  }
}
