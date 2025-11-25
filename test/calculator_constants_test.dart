import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_calculator/utils/calculator_logic.dart';

void main() {
  group("Math Constants Tests", () {
    test("pi constant", () {
      final result = double.parse(CalculatorLogic.evaluateExpression("pi"));
      expect(result, closeTo(3.1415926536, 1e-9));
    });

    test("e constant should return Error", () {
      final result = CalculatorLogic.evaluateExpression("e");
      expect(result, "Error");
    });

    test("Implicit multiplication: 2pi", () {
      final result = double.parse(CalculatorLogic.evaluateExpression("2pi"));
      expect(result, closeTo(6.2831853072, 1e-9));
    });
  });
}
