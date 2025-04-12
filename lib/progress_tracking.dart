import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'Services/weight_graph.dart';

final List<FlSpot> dailyProgress=[
  FlSpot(0, 5000),
  FlSpot(1,7000),
  FlSpot(2, 3000),
  FlSpot(3,8000),
  FlSpot(4, 4000),
  FlSpot(5, 10000),
  FlSpot(6, 9000),


];

class ProgressTracking extends StatelessWidget {


  const ProgressTracking({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Progress"),
          backgroundColor: Color.fromRGBO(137, 108, 254, 1)),
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),

      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  "Weight Progress",
                  style: TextStyle(color: Colors.white,fontSize: 18),
                ),
                const SizedBox(height:10),
                SizedBox(height:250,child: WeightGraph()),

                const SizedBox(height:30),

                const Text(
                  "Daily Steps",
                  style: TextStyle(color: Colors.white,fontSize: 18),
                ),
                const SizedBox(height:10),
                SizedBox(
                  height: 250,
                  child: DailyProgressChart(data: dailyProgress),
                ),
              ],
            ),

        ),

      );
  }
}



class DailyProgressChart extends StatelessWidget{
  final List<FlSpot> data;
  const DailyProgressChart({super.key,required this.data});

  @override
  Widget build(BuildContext context){
    return LineChart(
      LineChartData(
        gridData: FlGridData(show:true),
        titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true)
            ),
          bottomTitles:
            AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) => Text(
                  ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][value.toInt()],
                  style: TextStyle(fontSize: 10),
                ),
                interval: 1,
              )
            )

        ),
          borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots:data,
            isCurved: true,
            color:Colors.blue,
            barWidth: 3,
            dotData: FlDotData(show:true),
          )
        ]

      )

    );



  }




}



