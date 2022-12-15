import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class FactoringFormulas extends StatelessWidget {
  const FactoringFormulas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecialMethods.displayAppBar(context: context),
      backgroundColor: primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Factoring Formulas",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Math.tex(
                r"a^2 - b^2 = ( a + b )( a + b )",
                mathStyle: MathStyle.display,
                textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Math.tex(
                r"a^3 - b^3 = ( a - b )( a^2 + ab + b^2 )",
                mathStyle: MathStyle.display,
                textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Math.tex(
                r"a^3 + b^3 = ( a + b )( a^2 - ab + b^2 )",
                mathStyle: MathStyle.display,
                textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Math.tex(
                r"... ",
                mathStyle: MathStyle.display,
                textStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Math.tex(
                r"a^n + b^n = ( a + b )( \sum_{k = 0}^{n - 1} a^{k}(-b)^{n - k - 1} )",
                mathStyle: MathStyle.display,
                textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Math.tex(
                r"a^n - b^n = ( a - b )( \sum_{k = 0}^{n - 1} a^{k}b^{n - k - 1} )",
                mathStyle: MathStyle.display,
                textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
