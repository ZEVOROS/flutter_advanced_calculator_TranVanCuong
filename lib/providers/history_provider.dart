import 'package:flutter/material.dart';
import '../models/calculation_history.dart';

class HistoryProvider extends ChangeNotifier {
  final List<CalculationHistory> _history = [];

  List<CalculationHistory> get history => List.unmodifiable(_history);

  void add(CalculationHistory h) {
    _history.insert(0, h);
    if (_history.length > 100) _history.removeLast();
    notifyListeners();
  }

  void clear() {
    _history.clear();
    notifyListeners();
  }

  void loadFromList(List<CalculationHistory> list) {
    _history.clear();
    _history.addAll(list);
    notifyListeners();
  }
}
