import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_calculator/utils/calculator_logic.dart';

void main() {
  group("Parentheses Tests", () {
    test("Simple parentheses", () {
      final result = CalculatorLogic.evaluateExpression("(2+3)*4");
      final parsed = double.tryParse(result);
      expect(parsed, isNotNull);
    });

    test("Nested parentheses", () {
      final result = CalculatorLogic.evaluateExpression("((2+3)*4)-5");
      final parsed = double.tryParse(result);
      expect(parsed, isNotNull);
    });

    test("Mismatched parentheses returns Error", () {
      final result = CalculatorLogic.evaluateExpression("(2+3*4");
      expect(result, "Error");
    });
  });
}
