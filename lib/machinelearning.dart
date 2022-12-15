import 'dart:io';
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class MachineLearning extends StatefulWidget {
  const MachineLearning({Key? key}) : super(key: key);

  @override
  State<MachineLearning> createState() => _MachineLearningState();
}

class _MachineLearningState extends State<MachineLearning> {
  Map<String, Map<String, dynamic>> buttons = <String, Map<String, dynamic>>{
    "Vision": {
      "Barcode": [Colors.red, () {}],
      "Face Detection": [Colors.red, () {}],
      "Image Labeling": [Colors.red, () {}],
      "Object Detection": [Colors.red, () {}],
      "Text Recognition": [Colors.red, () {}],
      "Digital Ink Recognition": [Colors.red, () {}],
      "Pose Detection": [Colors.red, () {}],
      "Selfie Segmentation": [Colors.red, () {}],
    },
    "Natural Language Processing": {
      "Language Identification": [Colors.blue, () {}],
      "On-Device Translation": [Colors.blue, () {}],
      "Smart Reply": [Colors.blue, () {}],
      "Entity Extraction": [Colors.blue, () {}],
    },
  };
  File? imageFile;
  void googleMLKitTextReader() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      /*final visionImage = FirebaseVisionImage.fromFile(imageFile!);
      final textRecognizer = FirebaseVision.instance.textRecognizer();
      final textVision = await textRecognizer.processImage(visionImage);
      final String text =
          textVision.text == null ? "No Text Found" : textVision.text!;
      print(text);
      /*for (TextBlock block in recognizedText.blocks)
        for (TextLine line in block.lines) {
          text = text + line.text + "\n";
        }*/
      setState(() {});*/
    }
  }

  Widget buttonMaker(
      {required String text, required Color color, required void func()}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          color: color,
          onPressed: func,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecialMethods.displayAppBar(context: context),
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .3,
          ),
          Expanded(
            child: GroupListView(
                sectionSeparatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 10),
                separatorBuilder: (BuildContext context, IndexPath index) =>
                    const SizedBox(height: 10),
                padding: const EdgeInsets.all(8.0),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, IndexPath index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buttonMaker(
                          text: buttons[buttons.keys.toList()[index.section]]!
                              .keys
                              .toList()[index.index],
                          color: buttons[buttons.keys.toList()[index.section]]![
                              buttons[buttons.keys.toList()[index.section]]!
                                  .keys
                                  .toList()[index.index]][0],
                          func: buttons[buttons.keys.toList()[index.section]]![
                              buttons[buttons.keys.toList()[index.section]]!
                                  .keys
                                  .toList()[index.index]][1]),
                    ),
                sectionsCount: buttons.keys.toList().length,
                groupHeaderBuilder: (BuildContext context, int index) => Text(
                      buttons.keys.toList()[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                countOfItemInSection: (int index) =>
                    buttons[buttons.keys.toList()[index]]!
                        .keys
                        .toList()
                        .length),
          ),
        ],
      ),
    );
  }
}
