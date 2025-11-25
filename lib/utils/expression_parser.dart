import 'package:math_expressions/math_expressions.dart';

class ExpressionParser {
  static Expression parse(String input) {
    final parser = Parser();
    return parser.parse(input);
  }
}
