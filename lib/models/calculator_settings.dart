class CalculatorSettings {
  bool angleIsDegrees;
  int decimalPrecision;
  bool hapticFeedback;

  CalculatorSettings({
    this.angleIsDegrees = true,
    this.decimalPrecision = 6,
    this.hapticFeedback = false,
  });

  Map<String, dynamic> toJson() => {
    'angleIsDegrees': angleIsDegrees,
    'decimalPrecision': decimalPrecision,
    'hapticFeedback': hapticFeedback,
  };

  static CalculatorSettings fromJson(Map<String, dynamic> json) => CalculatorSettings(
    angleIsDegrees: json['angleIsDegrees'] as bool? ?? true,
    decimalPrecision: json['decimalPrecision'] as int? ?? 6,
    hapticFeedback: json['hapticFeedback'] as bool? ?? false,
  );
}
