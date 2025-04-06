import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class WeightGraph extends StatefulWidget {
  const WeightGraph({super.key});

  @override
  State<WeightGraph> createState() => _WeightGraphState();
}

class _WeightGraphState extends State<WeightGraph> {
  List<FlSpot> _spots = [];
  List<String> _dates = [];

  @override
  void initState() {
    super.initState();
    _loadWeightLogs();
  }

  Future<void> _loadWeightLogs() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      final logs = (doc.data()?['weightLogs'] ?? []) as List<dynamic>;

      logs.sort(
        (a, b) => (a['timestamp'] as Timestamp).compareTo(
          b['timestamp'] as Timestamp,
        ),
      );

      List<FlSpot> tempSpots = [];
      List<String> tempDates = [];

      for (int i = 0; i < logs.length; i++) {
        final entry = logs[i];
        final weight = (entry['weight'] as num?)?.toDouble();
        final timestamp = entry['timestamp'] as Timestamp?;

        if (weight != null && timestamp != null) {
          tempSpots.add(FlSpot(i.toDouble(), weight));
          tempDates.add(DateFormat('dd MMM').format(timestamp.toDate()));
        }
      }

      setState(() {
        _spots = tempSpots;
        _dates = tempDates;
      });
    } catch (e) {
      debugPrint('Error loading weight logs: $e');
    }
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int index = value.toInt();
    if (index >= 0 && index < _dates.length) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          _dates[index],
          style: const TextStyle(fontSize: 10, color: Colors.white),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.toInt().toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _spots.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Weight Graph",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    lineBarsData: [
                      LineChartBarData(
                        spots: _spots,
                        isCurved: true,
                        color: Colors.deepPurpleAccent,
                        barWidth: 3,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: true),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: leftTitleWidgets,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: bottomTitleWidgets,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        bottom: BorderSide(color: Colors.white),
                        left: BorderSide(color: Colors.white),
                      ),
                    ),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
