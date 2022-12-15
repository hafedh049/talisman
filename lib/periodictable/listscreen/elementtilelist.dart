import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tesla/periodictable/details/detailpage.dart';
import 'package:tesla/periodictable/elementData.dart';

class ElementListTile extends StatefulWidget {
  const ElementListTile({Key? key, required this.element}) : super(key: key);
  final ElementData element;
  @override
  State<ElementListTile> createState() => _ElementListTileState();
}

class _ElementListTileState extends State<ElementListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsPage(element: widget.element),
        ));
      },
      onDoubleTap: () {},
      child: SizedBox(
        height: 10.h,
        child: Card(
          margin: const EdgeInsets.all(8.0),
          color: Colors.blue.withOpacity(.05),
          child: ListTile(
            leading: Text(
              widget.element.symbol,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: widget.element.category.contains("lanthanide")
                    ? const Color.fromARGB(255, 255, 255, 255)
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
                                        : widget.element.category.contains(
                                                "alkaline earth metal")
                                            ? Colors.brown.shade400
                                            : Colors.blue,
              ),
            ),
            title: Text(widget.element.name,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white)),
            trailing: Text(widget.element.atomicWeight.toString(),
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
