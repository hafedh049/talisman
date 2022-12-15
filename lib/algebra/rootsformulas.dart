import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class RootsFormulas extends StatelessWidget {
  const RootsFormulas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecialMethods.displayAppBar(context: context),
      backgroundColor: primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Roots Formulas",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Math.tex(
                r"\sqrt[n]{a}\sqrt[n]{b} = \sqrt[nm]{a^mb^n}",
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
                r"\sqrt[n]{ab} = \sqrt[n]{a}\sqrt[n]{b}",
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
                r"\sqrt[n]{\frac{a}{b}} = \frac{\sqrt[n]{a}}{\sqrt[n]{b}}",
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
                r"\frac{\sqrt[n]{a}}{\sqrt[m]{b}} = \frac{\sqrt[nm]{a^m}}{\sqrt[nm]{b^n}} = \sqrt[nm]{\frac{a^m}{b^n}}",
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
                r"(\sqrt[n]{a})^n = a",
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
                r"(\sqrt[n]{a^m}) = a^{\frac{m}{n}}",
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
                r"(\sqrt[n]{a})^m = \sqrt[n]{a^m}",
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
                r"\sqrt[m]{\sqrt[n]{a}} = \sqrt[mn]{a}",
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
                r"\frac{1}{\sqrt[n]{a}} = \frac{\sqrt[n]{a^{n - 1}}}{a}",
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
                r"\sqrt{a \pm \sqrt{b}} = \sqrt{\frac{a + \sqrt{a^2 - b}}{2}} \pm \sqrt{\frac{a - \sqrt{a^2 - b}}{2}}",
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
                r"\frac{1}{\sqrt{a} \pm \sqrt{b}} = \frac{\sqrt{a} \mp \sqrt{b}}{a - b}",
                mathStyle: MathStyle.display,
                textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
