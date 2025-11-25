import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculation_history.dart';

class StorageService {
  static const _historyKey = 'calc_history_v1';
  static const _settingsKey = 'calc_settings_v1';

  Future<void> saveHistory(List<CalculationHistory> history) async {
    final prefs = await SharedPreferences.getInstance();
    final data = history.map((h) => h.toJson()).toList();
    prefs.setString(_historyKey, jsonEncode(data));
  }

  Future<List<CalculationHistory>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_historyKey);
    if (s == null) return [];
    try {
      final list = jsonDecode(s) as List<dynamic>;
      return list.map((e) => CalculationHistory.fromJson(Map<String, dynamic>.from(e))).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_settingsKey, jsonEncode(settings));
  }

  Future<Map<String, dynamic>?> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_settingsKey);
    if (s == null) return null;
    return Map<String, dynamic>.from(jsonDecode(s) as Map);
  }
}
