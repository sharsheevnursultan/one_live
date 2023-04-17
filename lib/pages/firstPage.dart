import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          elevatedButtonTheme: (ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color(0xffB3DDC6),
            ),
          )),
          fontFamily: 'Montserrat',
          buttonTheme: const ButtonThemeData(buttonColor: Color(0xffB3DDC6)),
          textTheme:
              const TextTheme(bodyText2: TextStyle(color: Color(0xff2c2c2c))),
          appBarTheme: const AppBarTheme(
            color: Color(0xfffaf7ed),
            iconTheme: IconThemeData(color: Colors.black),
            toolbarTextStyle: TextStyle(color: Color(0xff2c2c2c)),
            titleTextStyle: TextStyle(color: Color(0xff2c2c2c), fontSize: 20),
          ),
          primaryColor: const Color(0xfffaf7ed),
          scaffoldBackgroundColor: const Color(0xfffaf7ed),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color(0xffB3DDC6)),
        ),
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
