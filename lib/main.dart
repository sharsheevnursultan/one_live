import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:one_life/pages/main_date_picker.dart';
import 'package:one_life/pages/percent_tab.dart';
import 'package:one_life/pages/share.dart';
import 'package:one_life/pages/squares.dart';
import 'package:one_life/pages/theme.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'pages/start_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LifeTrackerState()),
      ChangeNotifierProvider(create: (_) => MyData()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/firstPage',
      routes: {
        '/firstPage': (context) => const FirstPage(),
        '/main': (context) => const LifeTracker(),
      },
      home: const LifeTracker(),
    );
  }
}

class LifeTracker extends StatefulWidget {
  const LifeTracker({super.key});

  @override
  LifeTrackerState createState() => LifeTrackerState();
}

class MyData extends ChangeNotifier {
  int _myAgeInYears = 0;
  int _myAgeInMonths = 0;
  int _myAgeInWeeks = 0;
  int _myAgeInDays = 0;
  int _myAgeInHours = 0;
  int _myAgeInMinutes = 0;
  int _myAgeInSeconds = 0;

  int get myAgeInYears => _myAgeInYears;

  int get myAgeInMonths => _myAgeInMonths;

  int get myAgeInWeeks => _myAgeInWeeks;

  int get myAgeInDays => _myAgeInDays;

  int get myAgeInHours => _myAgeInHours;

  int get myAgeInMinutes => _myAgeInMinutes;

  int get myAgeInSeconds => _myAgeInSeconds;

  void changeTime(DateTime birthdate) {
    Duration age = DateTime.now().difference(birthdate);
    int myAgeInYears = age.inDays ~/ 365;
    int myAgeInMonths = age.inDays ~/ 30;
    int myAgeInWeeks = (age.inDays / 7).floor();
    int myAgeInDays = age.inDays;
    int myAgeInHours = age.inHours;
    int myAgeInMinutes = age.inMinutes;
    int myAgeInSeconds = age.inSeconds;
    _myAgeInYears = myAgeInYears;
    _myAgeInMonths = myAgeInMonths;
    _myAgeInWeeks = myAgeInWeeks;
    _myAgeInDays = myAgeInDays;
    _myAgeInHours = myAgeInHours;
    _myAgeInMinutes = myAgeInMinutes;
    _myAgeInSeconds = myAgeInSeconds;
    notifyListeners();
  }
}

class LifeTrackerState extends State<LifeTracker> with ChangeNotifier {
  int averageLifeExpectancyInMonths = 876; // 73 years in months
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color(0xfffaf7ed),
            appBar: AppBar(
              title: const Text('One Life - Life Tracker',
                  style: TextStyle(fontFamily: "BakbakOne")),
              actions: <Widget>[
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      onPressed: () => sharePressed(context),
                      icon: const Icon(Icons.ios_share),
                      tooltip: 'Share App',
                    );
                  },
                ),
              ],
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.access_time),
                  ),
                  Tab(
                    icon: Icon(Icons.grid_view),
                  ),
                  Tab(
                    icon: Icon(Icons.percent),
                  ),
                  Tab(
                    icon: Icon(Icons.share),
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: <Widget>[
                MainDatePicker(),
                Squares(),
                PercentTab(),
                SharePage(),
              ],
            )));
  }

  // Share app link
  Future<void> sharePressed(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    String message =
        'https://apps.apple.com/app/one-life-life-tracker/id6447756806';
    await Share.share(
      message,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

}
