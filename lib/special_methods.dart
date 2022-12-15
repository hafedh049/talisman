import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CardBuilder extends StatefulWidget {
  final Color foregroundColor;
  double value;
  final String title;
  final String content;
  final Widget widget;
  var func;
  CardBuilder({
    Key? key,
    required this.foregroundColor,
    required this.title,
    required this.content,
    required this.value,
    required this.widget,
    required this.func,
  }) : super(key: key);

  @override
  State<CardBuilder> createState() => _CardBuilderState();
}

class _CardBuilderState extends State<CardBuilder> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      semanticContainer: true,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8,
          ),
          gradient: LinearGradient(
            colors: [
              widget.foregroundColor,
              widget.foregroundColor,
            ],
          ),
        ),
        child: ListTile(
          onTap: widget.func,
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.content,
                style: const TextStyle(
                  color: Colors.lightGreenAccent,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              widget.widget,
            ],
          ),
          trailing: Image.asset(
            "assets/tesla.png",
          ),
        ),
      ),
    );
  }
}

class SpecialMethods {
  static void displayDialog(
      {required BuildContext context,
      required String title,
      required String content}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 26, 25, 24),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 24,
              ),
            ),
            content: Text(
              content,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                color: Colors.green,
                child: const Text(" Understood "),
              ),
            ],
            actionsAlignment: MainAxisAlignment.end,
          );
        });
  }

  static PreferredSizeWidget displayAppBar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(
          context,
        ),
        icon: const Icon(
          Icons.arrow_left,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  static Widget displayListTile({
    required void func(),
    required IconData icon,
    required String text,
  }) {
    return ListTile(
      onTap: func,
      leading: Icon(
        icon,
        color: Colors.orange,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  static Widget displaySpecialStatisticsCard({
    required String imagePath,
    required void func(),
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        tileColor: Colors.white.withOpacity(.2),
        selectedColor: Colors.pinkAccent,
        onTap: func,
        subtitle: Center(child: LottieBuilder.asset(imagePath)),
      ),
    );
  }

  static ExpansionTile displayExpandedTile(
      {required Icon icon,
      required void onExpansionChanged(bool isExpanded),
      required Widget title,
      required List<Widget> children}) {
    return ExpansionTile(
      trailing: icon,
      onExpansionChanged: onExpansionChanged,
      title: title,
      children: children,
    );
  }

  static Widget displayTextFormField({
    required bool autofocus,
    required bool obscureText,
    required int maxLines,
    required String? func(String? value),
    required TextEditingController? controller,
    required FocusNode? focusNode,
    required String hintText,
    required prefixIcon,
    required suffixIcon,
    required TextInputType keyboardType,
  }) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      autofocus: autofocus,
      obscureText: obscureText,
      maxLines: maxLines,
      validator: func,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
      keyboardType: keyboardType,
    );
  }

  static Widget displayNeutrino() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: "Ne",
            style: TextStyle(
              color: Colors.red,
              fontSize: 40,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.red,
                  blurRadius: 12,
                ),
              ],
            ),
          ),
          TextSpan(
            text: "Ut",
            style: TextStyle(
              color: Colors.pink,
              fontSize: 40,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.pink,
                  blurRadius: 20,
                ),
              ],
            ),
          ),
          TextSpan(
            text: "Ri",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 40,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.blue,
                  blurRadius: 20,
                ),
              ],
            ),
          ),
          TextSpan(
            text: "No",
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 40,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.yellow,
                  blurRadius: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget displayMaterialButton({
    required Color color,
    required void whilePresesed(),
    required IconData icon,
    required String text,
  }) {
    return MaterialButton(
      color: color,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: whilePresesed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 5,
          ),
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
