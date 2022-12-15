import 'package:flutter/material.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';
import 'package:zefyrka/zefyrka.dart';

class TextEditor extends StatefulWidget {
  const TextEditor({Key? key}) : super(key: key);

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  ZefyrController zefyrController = ZefyrController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: SpecialMethods.displayAppBar(context: context),
      body: Column(
        children: [
          Expanded(
            child: ZefyrEditor(
              controller: zefyrController,
              padding: const EdgeInsets.all(8.0),
              scrollPhysics: const BouncingScrollPhysics(),
              onLaunchUrl: (String value) {},
            ),
          ),
          ZefyrToolbar.basic(controller: zefyrController),
        ],
      ),
    );
  }
}
