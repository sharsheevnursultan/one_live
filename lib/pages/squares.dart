import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_life/main.dart';
import 'package:provider/provider.dart';

class Squares extends StatefulWidget {
  const Squares({Key? key}) : super(key: key);

  @override
  State<Squares> createState() => _SquaresState();
}

class _SquaresState extends State<Squares> {
  List<Widget> squares = [];

  get myAgeInMonths => Provider.of<MyData>(context).myAgeInMonths;


  @override
  Widget build(BuildContext context) {
    final averageLifeExpectancyInMonths =Provider.of<LifeTrackerState>(context).averageLifeExpectancyInMonths;
    // final myAgeInMonths =Provider.of<MyData>(context).myAgeInMonths;
    print(averageLifeExpectancyInMonths);
    print(myAgeInMonths);
    for (int i = 0; i < averageLifeExpectancyInMonths; i++) {
      Color? color = const Color(0xffB3DDC6);
      if (i < myAgeInMonths) {
        color = const Color(0xff2c2c2c);
      }
      squares.add(
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
    }

    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Color(0xffFBF1A3),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Life of an average person in months.'),
                    const Text('One line equals 3 years'),
                    const SizedBox(height: 30),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 36,
                        children: squares,
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
