import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:tesla/error.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/periodictable/elementData.dart';
import 'package:tesla/periodictable/listscreen/elementtilelist.dart';
import 'package:tesla/special_methods.dart';

class ListPage extends StatelessWidget {
  ListPage({Key? key}) : super(key: key);
  final gridList = rootBundle
      .loadString("assets/periodic-table-lookup.json")
      .then((String value) => jsonDecode(value)["elements"] as List)
      .then((list) => list
          .map((json) => json != null ? ElementData.fromJson(json) : null)
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: SpecialMethods.displayAppBar(context: context),
      body: Body(
        gridList: gridList,
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key, required this.gridList}) : super(key: key);
  final Future<List<ElementData?>> gridList;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget buildTileList(List<ElementData?> elements) {
    final tiles = elements.map(
      (ElementData? element) {
        return element != null
            ? ElementListTile(element: element)
            : Container(
                height: 0,
              );
      },
    ).toList();
    return SingleChildScrollView(
      child: Column(
        children: tiles,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: widget.gridList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildTileList(snapshot.data as List<ElementData?>);
              } else if (snapshot.hasError) {
                return Error(error: snapshot.error.toString());
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
