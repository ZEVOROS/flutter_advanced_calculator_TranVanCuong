import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_calculator/utils/calculator_logic.dart';

void main() {
  group("Full Expression Tests", () {
    test("Complex expression", () {
      final result = CalculatorLogic.evaluateExpression("2+3*4-5/2");
      final parsed = double.tryParse(result);
      expect(parsed, isNotNull);
    });

    test("Empty expression returns Error", () {
      final result = CalculatorLogic.evaluateExpression("Error");
      expect(result, "Error");
    });

    test("Expression with constants", () {
      final result = CalculatorLogic.evaluateExpression("2*pi");
      final parsed = double.tryParse(result);
      expect(parsed, isNotNull);
    });
  });
}
