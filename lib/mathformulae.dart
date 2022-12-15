import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:tesla/algebra/binomialtheorem.dart';
import 'package:tesla/algebra/complexnumbers.dart';
import 'package:tesla/algebra/factoringformulas.dart';
import 'package:tesla/algebra/logarithmformulas.dart';
import 'package:tesla/algebra/powersformulas.dart';
import 'package:tesla/algebra/productformulas..dart';
import 'package:tesla/algebra/rootsformulas.dart';
import 'package:tesla/algebra/usefulequations.dart';
import 'package:tesla/special_methods.dart';

class MathFormulae extends StatefulWidget {
  const MathFormulae({Key? key}) : super(key: key);

  @override
  State<MathFormulae> createState() => _MathFormulaeState();
}

class _MathFormulaeState extends State<MathFormulae> {
  Widget makeExpansionTile(
      {required Widget title, required List<Widget> children}) {
    var isExpanded = false;
    return ExpansionTile(
      title: title,
      backgroundColor: Colors.transparent,
      leading: CircleAvatar(
        backgroundColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        radius: 20,
      ),
      onExpansionChanged: (bool expansion) {
        setState(() {
          isExpanded = expansion;
        });
      },
      trailing: Icon(
        isExpanded
            ? FontAwesomeIcons.chevronDown
            : FontAwesomeIcons.chevronLeft,
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        size: 20,
        shadows: <Shadow>[
          Shadow(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          )
        ],
      ),
      children: children,
    );
  }

  Widget makeText({required String text}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget makeListTile({required String title, required void func()}) {
    return ListTile(
      title: makeText(text: title),
      onTap: func,
    );
  }

  //Title()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecialMethods.displayAppBar(context: context),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(child: LottieBuilder.asset("assets/formulae.json")),
          ListView(
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              makeExpansionTile(
                title: makeText(text: "Algebra"),
                children: [
                  makeListTile(
                    title: "Factoring Formulas",
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const FactoringFormulas()));
                    },
                  ),
                  makeListTile(
                    title: "Product Formulas",
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ProductFormulas()));
                    },
                  ),
                  makeListTile(
                    title: "Roots Formulas",
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RootsFormulas()));
                    },
                  ),
                  makeListTile(
                    title: "Powers Formulas",
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const PowersFormulas()));
                    },
                  ),
                  makeListTile(
                    title: "Logarithm Formulas",
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LogarithmsFormulas()));
                    },
                  ),
                  makeListTile(
                    title: "Useful Equations",
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const UsefulEquations()));
                    },
                  ),
                  makeListTile(
                    title: "Complex Numbers",
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ComplexNumbers()));
                    },
                  ),
                  makeListTile(
                    title: "Binomial Theorem",
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BinomialTheorem()));
                    },
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Geometry"),
                children: [
                  makeListTile(
                    title: "Cone",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Cylinder",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Isoceles Triangle",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Equilateral Triangle",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Square",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Sphere",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Rectangle",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Rhombus",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Parallelogram",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Trapzoid",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Analytical Geometry"),
                children: [
                  makeListTile(
                    title: "2-D Coordiante System",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Circle",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Hyperbola",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Ellipse",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Parabola",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Derivative"),
                children: [
                  makeListTile(
                    title: "Limits Formulas",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Properties Of Derivative",
                    func: () {},
                  ),
                  makeListTile(
                    title: "General Derivative Formulas",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Trigonometric Functions",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Inverse Trigonometric Functions",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Hyperbolic Functions",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Inverse Hyperbolic Functions",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Integration"),
                children: [
                  makeListTile(
                    title: "Properties Of Integration",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Integration Of Rational Functions",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Integration Of Trigonometric Functions",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Integration Of Hyperbolic Functions",
                    func: () {},
                  ),
                  makeListTile(
                    title:
                        "Integration Of Exponentional And Logarithmic Functions",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Trigonometry"),
                children: [
                  makeListTile(
                    title: "Basics",
                    func: () {},
                  ),
                  makeListTile(
                    title: "General",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Sine Rule And Cosine Rule",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Table Of Angle",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Angle Transformation",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Half-Double-Multiple Angle",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Sum Of Functions",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Product Of Functions",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Powers Of Functions",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Euler's Formula",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Allied Angle Table",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Negative Angle Identities",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Laplace"),
                children: [
                  makeListTile(
                    title: "Properties Of Laplace Transform",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Functions Of Laplace Transform",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Fourier"),
                children: [
                  makeListTile(
                    title: "Fourier Series",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Fourier Transform Operations",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Table Of Fourier Transform",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Series"),
                children: [
                  makeListTile(
                    title: "Arithmitic Series",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Geometric Series",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Finite Series",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Binomial Series",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Power Series Expansions",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Numerical Methods"),
                children: [
                  makeListTile(
                    title: "Lagrange, Newton's Interpolation",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Newton's Forward/Backward Difference",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Numerical Integration",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Roots Of Equation",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Vector Calculas"),
                children: [
                  makeListTile(
                    title: "Vector Identities",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Probability"),
                children: [
                  makeListTile(
                    title: "Basics",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Expectation",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Variance",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Distributions",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Permutations",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Combinations",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Beta And Gamma"),
                children: [
                  makeListTile(
                    title: "Beta Functions",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Gamma Functions",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Beta-Gamma Relation",
                    func: () {},
                  ),
                ],
              ),
              makeExpansionTile(
                title: makeText(text: "Z-Transform"),
                children: [
                  makeListTile(
                    title: "Properties Of Z-Transform",
                    func: () {},
                  ),
                  makeListTile(
                    title: "Common Pairs",
                    func: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
