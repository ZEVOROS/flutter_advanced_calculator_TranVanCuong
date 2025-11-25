// Model: CalculationHistory
class CalculationHistory {
  final DateTime timestamp;
  final String expression;
  final String result;

  CalculationHistory({
    required this.timestamp,
    required this.expression,
    required this.result,
  });

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'expression': expression,
    'result': result,
  };

  static CalculationHistory fromJson(Map<String, dynamic> json) => CalculationHistory(
    timestamp: DateTime.parse(json['timestamp'] as String),
    expression: json['expression'] as String,
    result: json['result'] as String,
  );
}
