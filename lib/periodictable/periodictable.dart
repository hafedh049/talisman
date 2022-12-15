import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/periodictable/listscreen/listpage.dart';
import 'package:tesla/periodictable/tablescreen/tablepage.dart';

class PeriodicTable extends StatefulWidget {
  const PeriodicTable({Key? key}) : super(key: key);

  @override
  State<PeriodicTable> createState() => _PeriodicTableState();
}

class _PeriodicTableState extends State<PeriodicTable> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: primaryColor.withOpacity(
          .9,
        ),
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: SizerUtil.deviceType == DeviceType.tablet ? 9.h : 8.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                padding: const EdgeInsets.only(left: 5.0),
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(0);
                  });
                },
                icon: const Icon(
                  Icons.table_view,
                  color: Colors.greenAccent,
                ),
              ),
              IconButton(
                padding: const EdgeInsets.only(right: 5.0),
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(1);
                  });
                },
                icon: const Icon(
                  Icons.list,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[TablePage(), ListPage()],
      ),
    );
  }
}
