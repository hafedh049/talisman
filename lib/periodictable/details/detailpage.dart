import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/periodictable/elementData.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.element}) : super(key: key);
  final ElementData element;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      await launchUrlString(widget.element.source);
                    },
                    icon: const Icon(FontAwesomeIcons.earthAmericas)),
                SizedBox(
                  width: 2.w,
                )
              ],
            )
          ],
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(FontAwesomeIcons.caretLeft),
          ),
          backgroundColor: primaryColor,
          title: Text(
            widget.element.name,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: SizerUtil.deviceType == DeviceType.tablet ? 14.h : 12.h,
                child: Card(
                  color: Colors.pinkAccent.withOpacity(.01),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          "Overview",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(FontAwesomeIcons.atom, color: Colors.white)
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  "Number",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  widget.element.number.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                title: const Text(
                  "Symbol",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  widget.element.symbol,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                title: const Text(
                  "Atomic Mass",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  widget.element.atomicWeight.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                title: const Text(
                  "Category",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  widget.element.category,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                title: const Text(
                  "Color",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: widget.element.color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.element.summary,
                  softWrap: true,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
