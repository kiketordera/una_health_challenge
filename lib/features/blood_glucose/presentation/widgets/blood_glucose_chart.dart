import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/entities/blodd_glucose_sample.dart';

class BloodGlucoseChart extends StatelessWidget {
  final List<BloodGlucoseSample> samples;

  const BloodGlucoseChart({super.key, required this.samples});

  @override
  Widget build(BuildContext context) {
    if (samples.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No data to display')),
      );
    }

    final spots = _getPlotPoints(samples);

    return SizedBox(
      height: 300,
      child: LineChart(
        _buildChartData(spots),
      ),
    );
  }

  List<FlSpot> _getPlotPoints(List<BloodGlucoseSample> samples) {
    samples.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return samples.map((sample) {
      final x = sample.timestamp.millisecondsSinceEpoch.toDouble();
      final y = sample.value;
      return FlSpot(x, y);
    }).toList();
  }

  LineChartData _buildChartData(List<FlSpot> spots) {
    final minX = spots.first.x;
    final maxX = spots.last.x;
    final minY = spots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    final maxY = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    final avgY = spots.map((e) => e.y).reduce((a, b) => a + b) / spots.length;
    final medianY = _calculateMedian(spots);

    return LineChartData(
      minX: minX,
      maxX: maxX,
      minY: minY - 1,
      maxY: maxY + 1,
      gridData: const FlGridData(show: true),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: (maxX - minX) / 5,
            getTitlesWidget: _bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: true, interval: 1),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: false,
          dotData: const FlDotData(show: false),
          color: Colors.blue,
        ),
      ],
      extraLinesData: ExtraLinesData(horizontalLines: [
        HorizontalLine(
          y: avgY,
          color: Colors.green.withOpacity(0.7),
          strokeWidth: 2,
          dashArray: [5, 5],
          label: HorizontalLineLabel(
            show: true,
            alignment: Alignment.centerRight,
            style: const TextStyle(color: Colors.green),
            labelResolver: (_) => 'Avg',
          ),
        ),
        HorizontalLine(
          y: medianY,
          color: Colors.purple.withOpacity(0.7),
          strokeWidth: 2,
          dashArray: [5, 5],
          label: HorizontalLineLabel(
            show: true,
            alignment: Alignment.centerRight,
            style: const TextStyle(color: Colors.purple),
            labelResolver: (_) => 'Median',
          ),
        ),
      ]),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    final timestamp = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    final formattedDate = DateFormat('MM-dd HH:mm').format(timestamp);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(formattedDate, style: const TextStyle(fontSize: 10)),
    );
  }

  double _calculateMedian(List<FlSpot> spots) {
    final yValues = spots.map((e) => e.y).toList()..sort();
    final mid = yValues.length ~/ 2;
    if (yValues.length % 2 == 1) {
      return yValues[mid];
    } else {
      return (yValues[mid - 1] + yValues[mid]) / 2;
    }
  }
}
