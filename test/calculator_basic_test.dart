import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_calculator/utils/calculator_logic.dart';

void main() {
  group("Basic Arithmetic Tests", () {
    test("Addition", () {
      final result = double.parse(CalculatorLogic.evaluateExpression("2+3"));
      expect(result, 5);
    });

    test("Subtraction", () {
      final result = double.parse(CalculatorLogic.evaluateExpression("5-2"));
      expect(result, 3);
    });

    test("Multiplication", () {
      final result = double.parse(CalculatorLogic.evaluateExpression("3*4"));
      expect(result, 12);
    });

    test("Division", () {
      final result = double.parse(CalculatorLogic.evaluateExpression("10/2"));
      expect(result, 5);
    });

    test("Empty expression returns Error", () {
      final result = CalculatorLogic.evaluateExpression("");
      expect(result, "Error");
    });
  });
}
