import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MediaDemo(),
    ));

class MediaDemo extends StatelessWidget {
  const MediaDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [30.0, 55.0, 42.0, 80.0, 65.0];
    return Scaffold(
      appBar: AppBar(title: const Text('Media & Charts')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Icons',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.home, size: 35),
              Icon(Icons.favorite, size: 35),
              Icon(Icons.star, size: 35),
              Icon(Icons.settings, size: 35),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Image.network(
              'https://picsum.photos/600/250',
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const SizedBox(height: 150, child: Center(child: Text('Image unavailable'))),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Sales Trend',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (int i = 0; i < data.length; i++)
                        FlSpot(i.toDouble(), data[i]),
                    ],
                    isCurved: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Sales Bar Chart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                barGroups: [
                  for (int i = 0; i < data.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [BarChartRodData(toY: data[i])],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
