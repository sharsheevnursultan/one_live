import 'package:flutter/cupertino.dart';
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
    return CupertinoApp(
        theme: cupertinoTheme,
        debugShowCheckedModeBanner: false,
        home: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xfffaf7ed),
          child: SafeArea(
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
                      CupertinoButton.filled(
                        padding: const EdgeInsets.fromLTRB(15,5,15,5),
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
