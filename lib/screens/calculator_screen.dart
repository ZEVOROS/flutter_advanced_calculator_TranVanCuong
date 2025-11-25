import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../widgets/display_area.dart';
import '../widgets/button_grid.dart';
import '../widgets/mode_selector.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Calculator'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/history'),
            child: const Text("History", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            child: const Text("Settings", style: TextStyle(color: Colors.black)),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ModeSelector(),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              DisplayArea(),
              const SizedBox(height: 16),
              Expanded(child: ButtonGrid()),
            ],
          ),
        ),
      ),
    );
  }
}
