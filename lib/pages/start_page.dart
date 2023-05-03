import 'package:flutter/material.dart';
import 'package:one_life/pages/theme.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xfffaf7ed),
          body: SafeArea(
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'One Life - Life Tracker',
                    style: TextStyle(fontSize: 35, fontFamily: "BakbakOne"),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Color(0xffFBF1A3),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Text(
                      'The One Life app is designed to help you get to know your life better by displaying information about how much time you have already lived, and displaying this data in the form of numbers and tables.',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/main');
                          // Provider.of<LifeTrackerState>(context, listen: false).showInterstitialAd();
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ),
          // Your app screen body
        ));
  }


}
