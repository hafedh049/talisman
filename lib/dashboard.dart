import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tesla/graph.dart';
import 'package:tesla/linechart.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/piechart.dart';
import 'package:tesla/radarchart.dart';
import 'package:tesla/special_methods.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: SpecialMethods.displayAppBar(context: context),
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 2,
          children: <Widget>[
            SpecialMethods.displaySpecialStatisticsCard(
              imagePath: "assets/linechart.json",
              func: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LineCharted(),
                  ),
                );
              },
            ),
            SpecialMethods.displaySpecialStatisticsCard(
              imagePath: "assets/barchart.json",
              func: () {},
            ),
            SpecialMethods.displaySpecialStatisticsCard(
              imagePath: "assets/piechart.json",
              func: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const PieChartTwister(),
                  ),
                );
              },
            ),
            SpecialMethods.displaySpecialStatisticsCard(
              imagePath: "assets/radarchart.json",
              func: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const RadarChartPlotter(),
                  ),
                );
              },
            ),
            SpecialMethods.displaySpecialStatisticsCard(
              imagePath: "assets/heatmapcalendar.json",
              func: () {},
            ),
            SpecialMethods.displaySpecialStatisticsCard(
              imagePath: "assets/graph.json",
              func: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const GraphPlotting(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
