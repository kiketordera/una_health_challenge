import 'package:flutter/material.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/entities/blodd_glucose_sample.dart';

class StatisticsSection extends StatelessWidget {
  final List<BloodGlucoseSample> samples;

  const StatisticsSection({super.key, required this.samples});

  @override
  Widget build(BuildContext context) {
    if (samples.isEmpty) {
      return const Text('No data available for the selected dates.');
    }

    final values = samples.map((e) => e.value).toList()..sort();
    final min = values.first;
    final max = values.last;
    final avg = values.reduce((a, b) => a + b) / values.length;
    final median = values.length % 2 == 1
        ? values[values.length ~/ 2]
        : (values[values.length ~/ 2 - 1] + values[values.length ~/ 2]) / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Statistics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8.0),
        Text('Minimum: ${min.toStringAsFixed(2)} mmol/L'),
        Text('Maximum: ${max.toStringAsFixed(2)} mmol/L'),
        Text('Average: ${avg.toStringAsFixed(2)} mmol/L'),
        Text('Median: ${median.toStringAsFixed(2)} mmol/L'),
      ],
    );
  }
}
