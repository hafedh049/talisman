import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class LogarithmsFormulas extends StatelessWidget {
  const LogarithmsFormulas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: SpecialMethods.displayAppBar(context: context),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Logarithms Formulas",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Math.tex(
                r"\log_{a}{1} = 0",
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
                r"\log_{a}{a} = 1",
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
                r"\log_{a}{0} = \begin{cases} -\inf, & \text{if} \hspace{0.5cm} a \gt 1 \\ +\inf, & \text{if} \hspace{0.5cm} a \lt 1 \end{cases}",
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
                r"\log_{a}{\frac{x}{y}} = \log_{a}{x} - \log_{a}{y}",
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
                r"\log_{a}{xy} = \log_{a}{x} + \log_{a}{y}",
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
                r"\log_{a}{x^n} = n\log_{a}{x}",
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
                r"\log_{a}{\sqrt[n]{x}} = \frac{1}{n}\log_{a}{x}",
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
                r"\log_{a}{c} = \frac{1}{\log_{c}{a}}",
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
                r"\log_{a}{x} = \frac{\log_{c}{x}}{\log_{c}{a}}",
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
                r"a^{\log_{a}{x}} = x",
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
                r"\log_{e}{x} = \ln{x}",
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
