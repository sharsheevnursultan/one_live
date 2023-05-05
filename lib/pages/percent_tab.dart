import 'package:flutter/material.dart';
import 'package:one_life/main.dart';
import 'package:provider/provider.dart';

class PercentTab extends StatefulWidget {
  const PercentTab({Key? key}) : super(key: key);

  @override
  State<PercentTab> createState() => _PercentTabState();
}

class _PercentTabState extends State<PercentTab> {
  @override
  Widget build(BuildContext context) {
    final myAgeInSeconds = Provider.of<MyData>(context).myAgeInSeconds.toDouble();
    double percentComplete =  myAgeInSeconds / (73 * 365 * 24 * 60 * 60);
    int percentCompleteRounded = (percentComplete * 100).round();
    return Container(color: const Color(0xfffaf7ed),
      child: SingleChildScrollView(
        child: SafeArea(
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
                    const Text(
                        'According to the WHO, the average life expectancy worldwide is 73 years'),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                            style: const TextStyle(
                              fontFamily: "BakbakOne",
                              fontSize: 40,
                            ),
                            '$percentCompleteRounded% '
                        ),
                        const Text('of average life expectancy'),
                      ],
                    ),

                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      color: const Color(0xff2c2c2c),
                      backgroundColor: const Color(0xffB3DDC6),
                      value: percentComplete,
                      minHeight: 20,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
