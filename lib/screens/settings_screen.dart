import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/calculator_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final calc = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("<"),
            ),
            const SizedBox(width: 12),
            const Text("Settings"),
          ],
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme'),
            subtitle: const Text('System / Light / Dark'),
            onTap: () {},
          ),
          SwitchListTile(
            title: const Text('Angle in Degrees'),
            value: calc.angleIsDegrees,
            onChanged: (_) => calc.toggleAngleMode(),
          ),
          ListTile(
            title: const Text('Clear History'),
            onTap: () {
              calc.history.clear();
              calc.notifyListeners();
            },
          )
        ],
      ),
    );
  }
}
