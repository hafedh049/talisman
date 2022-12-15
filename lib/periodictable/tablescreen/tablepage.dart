import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tesla/error.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/periodictable/elementData.dart';
import 'package:tesla/periodictable/tablescreen/elementtile.dart';
import 'package:tesla/special_methods.dart';
import 'package:sizer/sizer.dart';

class TablePage extends StatefulWidget {
  TablePage({Key? key}) : super(key: key);
  final gridList = rootBundle
      .loadString("assets/periodic-table-lookup.json")
      .then((String value) => jsonDecode(value)["elements"] as List)
      .then((list) => list
          .map((json) => json != null ? ElementData.fromJson(json) : null)
          .toList());
  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: SpecialMethods.displayAppBar(context: context),
      body: FutureBuilder(
        future: widget.gridList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildTable(snapshot.data as List<ElementData?>);
          } else if (snapshot.hasError) {
            return Error(error: snapshot.error.toString());
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildTable(List<ElementData?> elements) {
    final tiles = elements.map(
      (ElementData? element) {
        return element != null
            ? ElementTile(element: element)
            : Container(
                margin: EdgeInsets.all(1.w),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
              );
      },
    ).toList();
    return SingleChildScrollView(
      child: SizedBox(
        height: 100.h,
        child: GridView.count(
          crossAxisCount: 10,
          scrollDirection: Axis.horizontal,
          children: tiles,
        ),
      ),
    );
  }
}
