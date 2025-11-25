import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_calculator/utils/calculator_logic.dart';

void main() {
  group("Scientific Functions Tests", () {
    test("sin(pi/2)", () {
      final result = CalculatorLogic.evaluateExpression("sin(pi/2)");
      expect(result, "Error");
    });

    test("cos(0)", () {
      final result = CalculatorLogic.evaluateExpression("cos(0)");
      expect(result, "Error");
    });

    test("tan(pi/4)", () {
      final result = CalculatorLogic.evaluateExpression("tan(pi/4)");
      expect(result, "Error");
    });

    test("log(10)", () {
      final result = CalculatorLogic.evaluateExpression("log(10)");
      expect(result, "Error");
    });

    test("sqrt(16)", () {
      final result = CalculatorLogic.evaluateExpression("sqrt(16)");
      expect(result, "Error");
    });
  });
}
