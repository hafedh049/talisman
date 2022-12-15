import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class BinomialTheorem extends StatelessWidget {
  const BinomialTheorem({Key? key}) : super(key: key);

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
                "Binomial Theorem",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Math.tex(
                r"(x + y)^n = \sum_{k = 0}^{n} {n \choose k} x^{n - k}y^k",
                mathStyle: MathStyle.display,
                textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Math.tex(
                r"\text{where,}",
                mathStyle: MathStyle.display,
                textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Math.tex(
                r"{n \choose k} = \frac{n!}{k!(n - k)!}",
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
