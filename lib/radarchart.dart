import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class RadarChartPlotter extends StatefulWidget {
  const RadarChartPlotter({Key? key}) : super(key: key);

  @override
  State<RadarChartPlotter> createState() => _RadarChartPlotterState();
}

class _RadarChartPlotterState extends State<RadarChartPlotter> {
  double sides = 1;
  bool reverseAxis = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: SpecialMethods.displayAppBar(context: context),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              const Text(
                "Uses Sides",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Slider(
                min: 1,
                max: 15,
                divisions: 15,
                label: sides.toStringAsFixed(2),
                value: sides,
                onChanged: (double? value) {
                  setState(() {
                    sides = value!;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              const Text(
                "Reverse Axis",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Switch(
                value: reverseAxis,
                onChanged: (bool? value) {
                  setState(() {
                    reverseAxis = value!;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: RadarChart(
              ticksTextStyle: const TextStyle(
                color: Colors.blue,
                fontSize: 12,
              ),
              featuresTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              sides: sides.toInt(),
              reverseAxis: reverseAxis,
              outlineColor: Colors.white,
              axisColor: Colors.pink,
              ticks: [
                ...List.generate(
                  20,
                  (index) => index.isEven ? index ~/ 2 : index * 3 + 1,
                ),
              ],
              features: const [
                "X",
                "Y",
                "Z",
              ],
              data: const [
                [
                  10.0,
                  20,
                  28,
                  5,
                  16,
                  15,
                  17,
                  6,
                ],
                [
                  14.5,
                  1,
                  4,
                  14,
                  23,
                  10,
                  6,
                  19,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
