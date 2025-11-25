import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculation_history.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Future<void> _exportCSV(BuildContext context) async {
    final calc = Provider.of<CalculatorProvider>(context, listen: false);
    final rows = <List<dynamic>>[
      ["Expression", "Result", "Time"],
      ...calc.history.map((h) => [h.expression, h.result, h.timestamp.toLocal().toString()]),
    ];
    final csv = const ListToCsvConverter().convert(rows);
    if (kIsWeb) {
      final bytes = utf8.encode(csv);
      final blob = html.Blob([bytes], 'text/csv');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "calculator_history.csv")
        ..click();
      html.Url.revokeObjectUrl(url);
      return;
    }
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/calculator_history.csv");
    await file.writeAsString(csv);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Exported to: ${file.path}")));
    }
  }

  Future<void> _exportPDF(BuildContext context) async {
    final calc = Provider.of<CalculatorProvider>(context, listen: false);
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(build: (_) => [
      pw.Text("Calculator History", style: pw.TextStyle(fontSize: 24)),
      pw.SizedBox(height: 16),
      pw.Table.fromTextArray(
        headers: ["Expression", "Result", "Time"],
        data: calc.history.map((h) => [h.expression, h.result, h.timestamp.toLocal().toString()]).toList(),
      ),
    ]));
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("<")),
            const SizedBox(width: 12),
            const Text("History"),
            const Spacer(),
            TextButton(onPressed: () => _exportCSV(context), child: const Text("Export CSV")),
            TextButton(onPressed: () => _exportPDF(context), child: const Text("Export PDF")),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: calc.history.length,
        itemBuilder: (_, i) {
          final h = calc.history[i];
          return ListTile(
            title: Text(h.expression),
            subtitle: Text('${h.result} — ${h.timestamp.toLocal()}'),
            onTap: () {
              calc.expression = h.expression;
              calc.notifyListeners();
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
