import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:one_life/pages/admob_service.dart';
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
  late InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  DateTime date = DateTime.now();

  dynamic savedDate = 0;

  get myAgeInYears => Provider.of<MyData>(context).myAgeInYears;

  get myAgeInMonths => Provider.of<MyData>(context).myAgeInMonths;

  get myAgeInDays => Provider.of<MyData>(context).myAgeInDays;

  get myAgeInWeeks => Provider.of<MyData>(context).myAgeInWeeks;

  get myAgeInMinutes => Provider.of<MyData>(context).myAgeInMinutes;

  get myAgeInHours => Provider.of<MyData>(context).myAgeInHours;

  get myAgeInSeconds => Provider.of<MyData>(context).myAgeInSeconds;

  //admobShow
  void showInterstitialAd() {
    if (_isInterstitialAdReady) {
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _isInterstitialAdReady = false;
    } else {
      print('Interstitial ad is not ready yet.');
    }
  }

  // Admob ads
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobService.interstitialAdUnitId!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) => setState(() {
            _interstitialAd = ad;
            _isInterstitialAdReady = true;
          }),
          onAdFailedToLoad: (LoadAdError error) =>
              print('InterstitialAd failed to load: $error'),
        ));
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

// This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.
  void showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system
              // navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

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
            body: TabBarView(
              children: <Widget>[
                SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                                'Select your birthday to find out your life data'),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${date.month}.${date.day}.${date.year}',
                                  style: const TextStyle(
                                    fontFamily: "BakbakOne",
                                    fontSize: 40,
                                    color: Color(0xff2c2c2c),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      CupertinoDatePicker(
                                        initialDateTime: date,
                                        mode: CupertinoDatePickerMode.date,
                                        use24hFormat: true,
                                        minimumYear: 1900,
                                        // This is called when the user changes the date.
                                        onDateTimeChanged: (DateTime newDate) {
                                          date = newDate;

                                          Provider.of<MyData>(context,
                                                  listen: false)
                                              .changeTime(date);
                                        },
                                      ),
                                    );

                                    // showInterstitialAd();
                                  },
                                  // Display a CupertinoDatePicker in date picker mode.
                                  // In this example, the date is formatted manually. You can
                                  // use the intl package to format the value based on the
                                  // user's locale settings.
                                  child: const Text(
                                    "Enter date",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: const BoxDecoration(
                                color: Color(0xffFBF1A3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Your age in:',
                                        style: TextStyle(
                                          fontFamily: "BakbakOne",
                                          fontSize: 40,
                                          // color: Color(0xff2c2c2c),
                                        ),
                                      ),
                                      Text(''),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('years:'),
                                      Text('$myAgeInYears'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('months:'),
                                      Text('$myAgeInMonths'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('weeks:'),
                                      Text('$myAgeInWeeks'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('days:'),
                                      Text('$myAgeInDays'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('hours:'),
                                      Text('$myAgeInHours'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('minutes:'),
                                      Text('$myAgeInMinutes'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('seconds:'),
                                      Text('$myAgeInSeconds'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            // ElevatedButton(onPressed: initialIndexController, child: Text('Next Tab')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Squares(),
                const PercentTab(),
                const SharePage(),
              ],
            )));
  }
  @override
  void dispose() {
    // очистка ресурсов вашего виджета здесь
    super.dispose(); // вызов родительского метода dispose()
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
