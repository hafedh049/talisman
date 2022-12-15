import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class PieChartTwister extends StatefulWidget {
  const PieChartTwister({Key? key}) : super(key: key);

  @override
  State<PieChartTwister> createState() => _PieChartTwisterState();
}

class _PieChartTwisterState extends State<PieChartTwister> {
  final fromKey = GlobalKey<FormState>();
  List<Row> labelList = <Row>[];
  bool actifToggled1 = false;
  bool actifToggled2 = false;
  bool actifToggled3 = false;
  bool actifToggled4 = false;
  bool actifToggled5 = false;
  bool actifToggled6 = false;
  String centerText = "";
  int chartLegendSpacing = 32;
  Map<int, List<String>> mapper = <int, List<String>>{
    0: ["", "0"]
  };
  int itemIndex = 0;
  ChartType chartType = ChartType.disc;
  BoxShape legendShape = BoxShape.circle;
  LegendPosition legendPosition = LegendPosition.right;
  Widget displaySettings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color.fromARGB(255, 119, 118, 118),
        shadowColor: Colors.pink,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "PIE CHART OPTIONS",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: const Text("Chart Type"),
                trailing: DropdownButton<ChartType>(
                  value: chartType,
                  items: const [
                    DropdownMenuItem(
                      value: ChartType.ring,
                      child: Text(
                        "Ring",
                      ),
                    ),
                    DropdownMenuItem(
                      value: ChartType.disc,
                      child: Text(
                        "Disc",
                      ),
                    ),
                  ],
                  onChanged: (ChartType? item) {
                    setState(() {
                      chartType = item!;
                    });
                  },
                ),
              ),
              SwitchListTile(
                title: const Text(
                  "Show Center Text",
                ),
                value: actifToggled1,
                onChanged: (bool state) {
                  setState(() {
                    actifToggled1 = state;
                    centerText = actifToggled1 ? "Statistics" : "";
                  });
                },
              ),
              ListTile(
                title: const Text("Chart Legend Spacing"),
                trailing: DropdownButton<int>(
                  value: chartLegendSpacing,
                  items: [
                    ...List.generate(
                      61,
                      (index) => DropdownMenuItem(
                        value: index,
                        child: Text("$index"),
                      ),
                    ),
                  ],
                  onChanged: (int? item) {
                    setState(() {
                      chartLegendSpacing = item!;
                    });
                  },
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "LEGEND OPTIONS",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SwitchListTile(
                title: const Text(
                  "Show Lengend",
                ),
                value: actifToggled2,
                onChanged: (bool state) {
                  setState(() {
                    actifToggled2 = state;
                  });
                },
              ),
              SwitchListTile(
                title: const Text(
                  "Show Legend In Row",
                ),
                value: actifToggled3,
                onChanged: (bool state) {
                  setState(() {
                    actifToggled3 = state;
                  });
                },
              ),
              ListTile(
                title: const Text("Legend Shape"),
                trailing: DropdownButton<BoxShape>(
                  value: legendShape,
                  items: const [
                    DropdownMenuItem(
                      value: BoxShape.circle,
                      child: Text("Circle"),
                    ),
                    DropdownMenuItem(
                      value: BoxShape.rectangle,
                      child: Text("Rectangle"),
                    ),
                  ],
                  onChanged: (BoxShape? item) {
                    setState(() {
                      legendShape = item!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Legend Position"),
                trailing: DropdownButton<LegendPosition>(
                  value: legendPosition,
                  items: const [
                    DropdownMenuItem(
                      value: LegendPosition.right,
                      child: Text("Right"),
                    ),
                    DropdownMenuItem(
                      value: LegendPosition.left,
                      child: Text("Left"),
                    ),
                    DropdownMenuItem(
                      value: LegendPosition.top,
                      child: Text("Top"),
                    ),
                    DropdownMenuItem(
                      value: LegendPosition.bottom,
                      child: Text("Bottom"),
                    ),
                  ],
                  onChanged: (LegendPosition? item) {
                    setState(() {
                      legendPosition = item!;
                    });
                  },
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "CHART VALUES OPTIONS",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SwitchListTile(
                title: const Text(
                  "Show Chart Values",
                ),
                value: actifToggled4,
                onChanged: (bool state) {
                  setState(() {
                    actifToggled4 = state;
                    if (!actifToggled4) {
                      actifToggled6 = false;
                      actifToggled5 = false;
                    }
                  });
                },
              ),
              SwitchListTile(
                title: const Text(
                  "Show Chart Values In Percentage",
                ),
                value: actifToggled5,
                onChanged: (bool state) {
                  setState(() {
                    if (actifToggled4) {
                      actifToggled5 = state;
                    } else {
                      actifToggled5 = false;
                    }
                  });
                },
              ),
              SwitchListTile(
                title: const Text(
                  "Show Chart Values Outside",
                ),
                value: actifToggled6,
                onChanged: (bool state) {
                  setState(() {
                    if (actifToggled4) {
                      actifToggled6 = state;
                    } else {
                      actifToggled6 = false;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row lineAdd({required int index}) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (String val) {
                if (val.isNotEmpty) {
                  setState(() {
                    mapper.update(
                      index,
                      (value) => [val, value[1]],
                      ifAbsent: () => [val, "0"],
                    );
                  });
                }
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "Label",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(Icons.text_fields),
              ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (String val) {
                if (val.isNotEmpty) {
                  setState(() {
                    mapper.update(
                      index,
                      (value) => [value[0], val],
                      ifAbsent: () => [val, "0"],
                    );
                  });
                }
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Value",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlockPicker(
                          pickerColor: Colors.green,
                          onColorChanged: (Color color) {});
                    });
              },
              icon: const Icon(
                Icons.color_lens,
                color: Colors.yellow,
                size: 30,
              ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: IconButton(
            onPressed: () {
              setState(() {
                labelList.removeLast();
              });
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.blue,
              size: 30,
            ),
          ),
        )
      ],
    );
  }

  Card displayDataChart() {
    return Card(
      color: const Color.fromARGB(255, 98, 97, 97),
      shadowColor: Colors.pink,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      labelList.add(lineAdd(index: itemIndex));
                      itemIndex++;
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              ],
            ),
            ...labelList,
          ],
        ),
      ),
    );
  }

  PieChart displayPieChart() {
    return PieChart(
      chartType: chartType,
      centerText: centerText,
      chartLegendSpacing: chartLegendSpacing + .0,
      dataMap: <String, double>{
        for (var item in mapper.keys)
          mapper[item]![0]: double.parse(mapper[item]![1])
      },
      chartValuesOptions: ChartValuesOptions(
        showChartValues: actifToggled4,
        showChartValuesInPercentage: actifToggled5,
        showChartValuesOutside: actifToggled6,
      ),
      legendOptions: LegendOptions(
        legendTextStyle: const TextStyle(color: Colors.white),
        showLegends: actifToggled2,
        showLegendsInRow: actifToggled3,
        legendShape: legendShape,
        legendPosition: legendPosition,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: SpecialMethods.displayAppBar(context: context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            return Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: displayPieChart(),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: displayDataChart(),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: displaySettings(),
                )
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  displayPieChart(),
                  displaySettings(),
                  displayDataChart(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
