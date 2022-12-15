import 'package:flutter/material.dart';
import 'package:tesla/periodictable/details/detailpage.dart';
import 'package:tesla/periodictable/elementData.dart';
import 'package:sizer/sizer.dart';

class ElementTile extends StatefulWidget {
  const ElementTile({Key? key, required this.element}) : super(key: key);
  final ElementData element;
  @override
  State<ElementTile> createState() => _ElementTileState();
}

class _ElementTileState extends State<ElementTile> {
  @override
  Widget build(BuildContext context) {
    final tileColumnText = <Widget>[
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          "${widget.element.number}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      Text(
        widget.element.symbol,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Text(
        widget.element.name,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Divider(
          thickness: 1,
          indent: 3,
          endIndent: 3,
          color: /*widget.element.color*/ widget.element.category
                  .contains("lanthanide")
              ? Colors.brown.shade900
              : widget.element.category.contains("actinide")
                  ? Colors.pinkAccent.shade100
                  : widget.element.category.contains("transition metal")
                      ? Colors.red
                      : widget.element.category.contains("noble gas")
                          ? Colors.purple.shade900
                          : widget.element.category
                                  .contains("diatomic nonmetal")
                              ? Colors.green
                              : widget.element.category
                                      .contains("polyatomic nonmetal")
                                  ? Colors.yellow
                                  : widget.element.category
                                          .contains("alkaline earth metal")
                                      ? Colors.brown.shade400
                                      : Colors.blue,
        ),
      )
    ];
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsPage(element: widget.element),
        ));
      },
      onDoubleTap: () {},
      child: Container(
        margin: EdgeInsets.all(.4.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: tileColumnText,
        ),
      ),
    );
  }
}
