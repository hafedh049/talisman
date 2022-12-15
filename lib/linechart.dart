import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class LineCharted extends StatefulWidget {
  const LineCharted({Key? key}) : super(key: key);

  @override
  State<LineCharted> createState() => _LineChartedState();
}

class _LineChartedState extends State<LineCharted> {
  double? maxX = 6;
  double? maxY = 6;
  bool? showGrid = true;
  bool? showDots = true;
  List<Color> belowBarDataGradient = <Color>[
    Colors.blue.withOpacity(.1),
    Colors.lightBlueAccent.withOpacity(.6),
  ];
  bool? showBelowBarDataGradient = true;
  bool? isCurved = true;
  double? barwidth = 2;
  Color? curveColor = Colors.blue;
  double? curveSmoothness = 1;
  List<FlSpot> spotsList = <FlSpot>[const FlSpot(0, 0)];
  List<List<Widget>> pointsList = <List<Widget>>[];
  List<List<TextEditingController>> pointsListControllers =
      <List<TextEditingController>>[];
  List<bool> coordnatesState = [];

  @override
  void dispose() {
    super.dispose();
    for (List<TextEditingController> item in pointsListControllers) {
      item[0].dispose();
      item[1].dispose();
    }
    pointsListControllers.clear();
    pointsList.clear();
    spotsList.clear();
    coordnatesState.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecialMethods.displayAppBar(context: context),
      backgroundColor: primaryColor,
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                show: false,
              ),
              minX: 0,
              maxX: maxX,
              minY: 0,
              maxY: maxY,
              gridData: FlGridData(
                show: showGrid,
              ),
              lineBarsData: [
                LineChartBarData(
                  dotData: FlDotData(
                    show: showDots,
                  ),
                  belowBarData: BarAreaData(
                    gradient: LinearGradient(
                      colors: belowBarDataGradient,
                    ),
                    show: showBelowBarDataGradient,
                  ),
                  isCurved: isCurved,
                  barWidth: barwidth,
                  show: true,
                  color: curveColor,
                  curveSmoothness: curveSmoothness,
                  spots: spotsList,
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 1,
                          sigmaY: 1,
                        ),
                        child: AlertDialog(
                          backgroundColor: primaryColor,
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "maxX",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    StatefulBuilder(
                                        builder: (context, setcurrentState) {
                                      return Slider(
                                        min: 6.0,
                                        max: 100.0,
                                        divisions: 16,
                                        thumbColor: Colors.greenAccent,
                                        activeColor:
                                            Colors.white.withOpacity(.5),
                                        inactiveColor: Colors.blueAccent,
                                        value: maxX!,
                                        onChanged: (value) {
                                          setcurrentState(
                                            () {
                                              maxX = value;
                                            },
                                          );
                                          setState(() {});
                                        },
                                      );
                                    }),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "maxY",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    StatefulBuilder(
                                        builder: (context, setcurrentState) {
                                      return Slider(
                                        min: 6.0,
                                        max: 100.0,
                                        divisions: 16,
                                        thumbColor: Colors.greenAccent,
                                        activeColor:
                                            Colors.white.withOpacity(.5),
                                        inactiveColor: Colors.blueAccent,
                                        value: maxY!,
                                        onChanged: (value) {
                                          setcurrentState(
                                            () {
                                              maxY = value;
                                            },
                                          );
                                          setState(() {});
                                        },
                                      );
                                    }),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Line Width",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Container(
                                      width: 168,
                                      child: StatefulBuilder(
                                          builder: (context, setcurrentState) {
                                        return Slider(
                                          min: 1.0,
                                          max: 20.0,
                                          divisions: 20,
                                          thumbColor: Colors.greenAccent,
                                          activeColor:
                                              Colors.white.withOpacity(.5),
                                          inactiveColor: Colors.blueAccent,
                                          value: barwidth!,
                                          onChanged: (value) {
                                            setcurrentState(
                                              () {
                                                barwidth = value;
                                              },
                                            );
                                            setState(() {});
                                          },
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Smoothness",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Container(
                                      width: 155,
                                      child: StatefulBuilder(
                                          builder: (context, setcurrentState) {
                                        return Slider(
                                          min: 0.0,
                                          max: 3.0,
                                          divisions: 30,
                                          thumbColor: Colors.greenAccent,
                                          activeColor:
                                              Colors.white.withOpacity(.5),
                                          inactiveColor: Colors.blueAccent,
                                          value: curveSmoothness!,
                                          onChanged: (value) {
                                            setcurrentState(
                                              () {
                                                curveSmoothness = value;
                                              },
                                            );
                                            setState(() {});
                                          },
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                StatefulBuilder(
                                    builder: (context, setcurrentState) {
                                  return SwitchListTile(
                                    inactiveTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.pinkAccent,
                                    title: const Text(
                                      "Show Grid",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    value: showGrid!,
                                    onChanged: (value) {
                                      setcurrentState(
                                        () {
                                          showGrid = value;
                                        },
                                      );
                                      setState(() {});
                                    },
                                  );
                                }),
                                StatefulBuilder(
                                    builder: (context, setcurrentState) {
                                  return SwitchListTile(
                                    inactiveTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.pinkAccent,
                                    title: const Text(
                                      "Show Dots",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    value: showDots!,
                                    onChanged: (value) {
                                      setcurrentState(
                                        () {
                                          showDots = value;
                                        },
                                      );
                                      setState(() {});
                                    },
                                  );
                                }),
                                StatefulBuilder(
                                    builder: (context, setcurrentState) {
                                  return SwitchListTile(
                                    inactiveTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.pinkAccent,
                                    title: const Text(
                                      "Show Gradients Below Curve",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    value: showBelowBarDataGradient!,
                                    onChanged: (value) {
                                      setcurrentState(
                                        () {
                                          showBelowBarDataGradient = value;
                                        },
                                      );
                                      setState(() {});
                                    },
                                  );
                                }),
                                StatefulBuilder(
                                    builder: (context, setcurrentState) {
                                  return SwitchListTile(
                                    inactiveTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.pinkAccent,
                                    title: const Text(
                                      "Curved",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    value: isCurved!,
                                    onChanged: (value) {
                                      setcurrentState(
                                        () {
                                          isCurved = value;
                                        },
                                      );
                                      setState(() {});
                                    },
                                  );
                                }),
                                const Divider(
                                  thickness: 2,
                                  height: 5,
                                  color: Colors.amber,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                StatefulBuilder(
                                  builder: (context, setcurrentState) {
                                    return Column(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional.topEnd,
                                          child: IconButton(
                                            onPressed: () {
                                              TextEditingController
                                                  xController =
                                                  TextEditingController(
                                                      text: "");
                                              TextEditingController
                                                  yController =
                                                  TextEditingController(
                                                      text: "");

                                              TextField x = TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: xController,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "X",
                                                  labelStyle: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          Colors.indigoAccent,
                                                    ),
                                                  ),
                                                ),
                                              );
                                              TextField y = TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: yController,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "Y",
                                                  labelStyle: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          Colors.indigoAccent,
                                                    ),
                                                  ),
                                                ),
                                              );

                                              pointsList.add(
                                                [
                                                  Expanded(child: x),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(child: y),
                                                ],
                                              );
                                              pointsListControllers.add(
                                                [
                                                  xController,
                                                  yController,
                                                ],
                                              );
                                              coordnatesState.add(true);
                                              setState(() {});
                                              setcurrentState(() {});
                                            },
                                            icon: const Icon(
                                              FontAwesomeIcons.squarePlus,
                                              color: Colors.greenAccent,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                for (int index = 0;
                                                    index < pointsList.length;
                                                    index++)
                                                  Row(
                                                    children: [
                                                      ...pointsList[index],
                                                      Expanded(
                                                        child: IconButton(
                                                          onPressed: () {
                                                            if (index <
                                                                spotsList
                                                                        .length -
                                                                    1) {
                                                              spotsList
                                                                  .removeAt(
                                                                      index +
                                                                          1);
                                                            }
                                                            pointsList.removeAt(
                                                                index);
                                                            TextEditingController
                                                                xC =
                                                                pointsListControllers[
                                                                    index][0];
                                                            xC.dispose();
                                                            TextEditingController
                                                                yC =
                                                                pointsListControllers[
                                                                    index][1];
                                                            yC.dispose();
                                                            pointsListControllers
                                                                .removeAt(
                                                                    index);
                                                            setcurrentState(
                                                                () {});
                                                            setState(() {});
                                                          },
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: IconButton(
                                                          onPressed:
                                                              coordnatesState[
                                                                      index]
                                                                  ? () {
                                                                      if (pointsListControllers[index][0]
                                                                              .text
                                                                              .trim()
                                                                              .contains(RegExp(
                                                                                  r"^\-?\d*\.?\d+$")) &&
                                                                          pointsListControllers[index][1]
                                                                              .text
                                                                              .trim()
                                                                              .contains(RegExp(r"^\-?\d*\.?\d+$"))) {
                                                                        setcurrentState(
                                                                          () {
                                                                            spotsList.add(FlSpot(double.parse(pointsListControllers[index][0].text.trim()),
                                                                                double.parse(pointsListControllers[index][1].text.trim())));
                                                                            coordnatesState[index] =
                                                                                false;
                                                                          },
                                                                        );

                                                                        setState(
                                                                            () {});
                                                                      }
                                                                    }
                                                                  : null,
                                                          icon: Icon(
                                                            Icons.addchart,
                                                            color:
                                                                coordnatesState[
                                                                        index]
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .grey,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
