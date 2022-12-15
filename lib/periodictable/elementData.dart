import 'package:flutter/material.dart';

class ElementData {
  late final String name, symbol, source, category, summary;
  late final int number;
  late final Color color;
  late final double atomicWeight;
  ElementData.fromJson(Map<String, dynamic>? json)
      : name = json!["name"],
        symbol = json["symbol"],
        source = json["source"],
        number = json["number"],
        color = Color(int.parse("ff${json["color"]}", radix: 16)),
        atomicWeight = json["atomic_mass"].toDouble(),
        category = json["category"],
        summary = json["summary"];
}
