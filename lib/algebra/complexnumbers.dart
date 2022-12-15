import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class ComplexNumbers extends StatelessWidget {
  const ComplexNumbers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecialMethods.displayAppBar(context: context),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text(
                "Complex Numbers",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Math.tex(
                r"i = \sqrt{-1}",
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
                r"i^2 = -1",
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
                r"z = a + bi",
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
                r"(a + bi) + (c + di) = (a + c) + (b + d)i",
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
                r"(a + bi) - (c + di) = (a - c) + (b - d)i",
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
                r"(a + bi)(c + di) = (ac - bd) + (bc - ad)i",
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
                r"(a + bi)(a - bi) = a^2 + b^2",
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
                r"| z | = | a + bi | = \sqrt{a^2 + b^2}",
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
                r"\bar{z} = \bar{a + bi} = (a - bi)",
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
                r"\text{DeMoivre's Theorem}",
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
                r"[r(\cos{\theta} + i\sin{\theta})]^n = r^n(\cos{n\theta} + i\sin{n\theta})",
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
