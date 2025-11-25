import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

class CalculatorLogic {
  static String evaluateExpression(String expr, {bool deg = true}) {
    if (expr == null) return "Error";
    expr = expr.trim();
    if (expr.isEmpty) return "Error";

    try {
      final double result = _evaluateToDouble(expr, deg: deg);
      if (result.isInfinite || result.isNaN) return "Error";
      return _formatResult(result);
    } catch (_) {
      return "Error";
    }
  }

  double calculateExpression(String expr, {bool deg = true}) {
    return _evaluateToDouble(expr, deg: deg);
  }

  static double _evaluateToDouble(String rawExpr, {bool deg = true}) {
    if (rawExpr == null) throw Exception("Invalid expression");
    String expr = rawExpr.trim();
    if (expr.isEmpty) throw Exception("Empty");
    if (_hasInvalidSyntax(expr)) throw Exception("Syntax");
    expr = _normalize(expr);
    if (deg) expr = _convertTrigDegrees(expr);
    expr = _fixImplicitMultiplication(expr);
    expr = _cleanupOperators(expr);

    try {
      final Parser parser = Parser();
      final Expression parsed = parser.parse(expr);

      final ContextModel cm = ContextModel();
      cm.bindVariableName('pi', Number(math.pi));
      cm.bindVariableName('e', Number(math.e));

      final double result =
      parsed.evaluate(EvaluationType.REAL, cm).toDouble();

      if (result.isInfinite || result.isNaN) throw Exception("Math error");

      return result;
    } catch (e) {
      throw Exception("Parse/Eval error: ${e.toString()}");
    }
  }

  static bool _hasInvalidSyntax(String expr) {
    final invalidOps = RegExp(r'(\+\+|--|\*\*|\/\/|\+\*|\+\/|\*\+|\/\+|\^\^)');
    if (invalidOps.hasMatch(expr)) return true;
    int bal = 0;
    for (var i = 0; i < expr.length; i++) {
      if (expr[i] == '(') bal++;
      if (expr[i] == ')') bal--;
      if (bal < 0) return true;
    }
    if (bal != 0) return true;
    final trimmed = expr.trim();
    if (trimmed.isEmpty) return true;
    if (RegExp(r'^[\+\*\/\^]').hasMatch(trimmed)) return true;
    if (RegExp(r'[\+\-\*\/\^]$').hasMatch(trimmed) &&
        !RegExp(r'[-]$').hasMatch(trimmed)) {
      return true;
    }
    if (!RegExp(r'^[0-9A-Za-zππ\.\+\-\*\/\^\%\(\), ]+$').hasMatch(expr)) {
      return true;
    }
    return false;
  }

  static String _normalize(String expr) {
    expr = expr.replaceAll('×', '*');
    expr = expr.replaceAll('÷', '/');
    expr = expr.replaceAll('−', '-');
    expr = expr.replaceAll('–', '-');
    expr = expr.replaceAll('π', 'pi');
    expr = expr.replaceAll(RegExp(r'\s+'), '');

    return expr;
  }

  static String _convertTrigDegrees(String expr) {
    expr = expr.replaceAllMapped(
        RegExp(r'sin\('), (m) => 'sin_deg_open_marker('); // temporary
    expr = expr.replaceAllMapped(
        RegExp(r'cos\('), (m) => 'cos_deg_open_marker(');
    expr = expr.replaceAllMapped(
        RegExp(r'tan\('), (m) => 'tan_deg_open_marker(');

    // Now find matching parentheses for each marker and wrap with *pi/180
    expr = _replaceDegMarkers(expr, 'sin_deg_open_marker', 'sin');
    expr = _replaceDegMarkers(expr, 'cos_deg_open_marker', 'cos');
    expr = _replaceDegMarkers(expr, 'tan_deg_open_marker', 'tan');

    return expr;
  }

  static String _replaceDegMarkers(
      String expr, String marker, String funcName) {
    int idx = expr.indexOf(marker + '(');
    while (idx != -1) {
      int start = idx + marker.length; // index of '('
      if (start >= expr.length || expr[start] != '(') break;

      int depth = 0;
      int j = start;
      for (; j < expr.length; j++) {
        if (expr[j] == '(') depth++;
        if (expr[j] == ')') {
          depth--;
          if (depth == 0) break;
        }
      }
      if (j >= expr.length) break; // unmatched -> leave as is

      String inner = expr.substring(start + 1, j);
      String replacement = '$funcName((${inner})*pi/180)';
      expr = expr.replaceRange(idx, j + 1, replacement);

      idx = expr.indexOf(marker + '(', idx + replacement.length);
    }
    return expr;
  }

  static String _fixImplicitMultiplication(String expr) {
    expr = expr.replaceAllMapped(RegExp(r'(\d)\('), (m) => '${m[1]}*(');
    expr = expr.replaceAllMapped(RegExp(r'\)\('), (m) => ')*(');
    expr = expr.replaceAllMapped(RegExp(r'\)(?=[0-9a-zA-Z])'),
            (m) => ')*');
    expr = expr.replaceAllMapped(RegExp(r'(\d)(?=[a-zA-Z])'), (m) => '${m[1]}*');

    expr = expr.replaceAllMapped(RegExp(r'pi(?=[0-9\(])'), (m) => 'pi*');

    expr = expr.replaceAllMapped(RegExp(r'([a-zA-Z0-9\)])\('), (m) {
      return '${m[1]}*(';
    });

    return expr;
  }

  static String _cleanupOperators(String expr) {
    expr = expr.replaceAll('+-', '-');
    expr = expr.replaceAll('-+', '-');
    expr = expr.replaceAll('++', '+');
    expr = expr.replaceAll('--', '+');
    expr = expr.replaceAll(RegExp(r'^\+'), '');
    return expr;
  }

  static String _formatResult(double value) {
    if (value.abs() < 1e-12) value = 0.0;

    if ((value - value.truncate()).abs() < 1e-10) {
      return value.truncate().toString();
    }
    String s = value.toStringAsFixed(10);
    s = s.replaceAll(RegExp(r'\.?0+$'), '');
    return s;
  }
}
