import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tesla/authentification/forgetpassword.dart';
import 'package:tesla/biometrics.dart';

class Resetter extends StatefulWidget {
  const Resetter({Key? key}) : super(key: key);

  @override
  State<Resetter> createState() => _ResetterState();
}

class _ResetterState extends State<Resetter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: CustomPaint(
              size: Size(
                  MediaQuery.of(context).size.width,
                  (MediaQuery.of(context).size.width * 2.2) //1.875
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const Biometrics();
                        },
                      ),
                    );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.fingerprint,
                    size: 50,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const ForgetPassword();
                        },
                      ),
                    );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.vault,
                    size: 50,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 255, 0, 104)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.2680000);
    path0.lineTo(size.width * 0.3700000, 0);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);

    Paint paint1 = Paint()
      ..color = const Color.fromARGB(255, 36, 24, 61)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path1 = Path();
    path1.moveTo(0, size.height * 0.2653333);
    path1.lineTo(size.width * 0.3700000, 0);
    path1.lineTo(size.width, 0);
    path1.lineTo(size.width, size.height * 0.3986667);
    path1.lineTo(0, size.height * 0.5986667);
    path1.lineTo(0, size.height * 0.2653333);
    path1.close();

    canvas.drawPath(path1, paint1);

    Paint paint2 = Paint()
      ..color = const Color.fromARGB(255, 0, 255, 226)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path2 = Path();
    path2.moveTo(0, size.height * 0.5960000);
    path2.lineTo(0, size.height * 0.7986667);
    path2.lineTo(size.width, size.height * 0.9040000);
    path2.lineTo(size.width, size.height * 0.3973333);
    path2.lineTo(0, size.height * 0.5960000);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
