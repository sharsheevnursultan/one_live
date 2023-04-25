import 'dart:io' show File, Platform;
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'pages/firstPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    const MyApp(),
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
      theme: ThemeData(
        fontFamily: 'Montserrat',
        elevatedButtonTheme: (ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xffB3DDC6)))),
        buttonTheme: const ButtonThemeData(buttonColor: Color(0xffB3DDC6)),
        textTheme:
            const TextTheme(bodyMedium: TextStyle(color: Color(0xff2c2c2c))),
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
      // theme: ThemeData.dark(),
      initialRoute: '/firstPage',
      routes: {
        '/firstPage': (context) => const MainPage(),
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

class AdMobService {
  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2550588570628296/9765381559';
    } else if (Platform.isIOS) {
      //work ad
      return 'ca-app-pub-2550588570628296/1296225985';
      // test ad
      // return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }
}

class LifeTrackerState extends State<LifeTracker> {
  late InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  // WidgetsToImageController to access widget
  WidgetsToImageController controller = WidgetsToImageController();

  // to save image bytes of widget
  Uint8List? bytes;

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

  void _updateAgeInOtherUnits(DateTime birthdate) {
    Duration age = DateTime.now().difference(birthdate);
    int ageInYears = age.inDays ~/ 365;
    int ageInMonths = age.inDays ~/ 30;
    int ageInWeeks = (age.inDays / 7).floor();
    int ageInDays = age.inDays;
    int ageInHours = age.inHours;
    int ageInMinutes = age.inMinutes;
    int ageInSeconds = age.inSeconds;
    setState(() {
      _ageInYears = ageInYears;
      _ageInMonths = ageInMonths;
      _ageInWeeks = ageInWeeks;
      _ageInDays = ageInDays;
      _ageInHours = ageInHours;
      _ageInMinutes = ageInMinutes;
      _ageInSeconds = ageInSeconds;
    });
  }

  final int _averageLifeExpectancyInMonths = 876; // 73 years in months
  int _ageInYears = 0;
  int _ageInMonths = 0;
  int _ageInWeeks = 0;
  int _ageInDays = 0;
  int _ageInHours = 0;
  int _ageInMinutes = 0;
  int _ageInSeconds = 0;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    loadImage();
  }

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
  Widget build(BuildContext context) {
    List<Widget> squares = [];
    for (int i = 0; i < _averageLifeExpectancyInMonths; i++) {
      Color? color = const Color(0xffB3DDC6);
      if (i < _ageInMonths) {
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
    double percentComplete = _ageInSeconds / (73 * 365 * 24 * 60 * 60);
    int percentCompleteRounded = (percentComplete * 100).round();
    int percentHaveRounded = (percentCompleteRounded - 100).abs().round();
    int yearsHave = _averageLifeExpectancyInMonths ~/ 12 - _ageInYears.toInt();

    // This function displays a CupertinoModalPopup with a reasonable fixed height
    // which hosts CupertinoDatePicker.
    void _showDialog(Widget child) {
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
                                    _showDialog(
                                      CupertinoDatePicker(
                                        initialDateTime: date,
                                        mode: CupertinoDatePickerMode.date,
                                        use24hFormat: true,
                                        minimumYear: 1900,
                                        // This is called when the user changes the date.
                                        onDateTimeChanged: (DateTime newDate) {
                                          date = newDate;
                                          _updateAgeInOtherUnits(date);
                                        },
                                      ),
                                    );
                                    showInterstitialAd();
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
                                      Text('$_ageInYears'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('months:'),
                                      Text('$_ageInMonths'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('weeks:'),
                                      Text('$_ageInWeeks'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('days:'),
                                      Text('$_ageInDays'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('hours:'),
                                      Text('$_ageInHours'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('minutes:'),
                                      Text('$_ageInMinutes'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('seconds:'),
                                      Text('$_ageInSeconds'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: const BoxDecoration(
                              color: Color(0xffFBF1A3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                    'Life of an average person in months.'),
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
                        ))),
                SingleChildScrollView(
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
                                        // color: Color(0xff2c2c2c),
                                      ),
                                      '$percentCompleteRounded% '),
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
                SafeArea(
                  child: Center(
                    child: ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(
                              child: Text(
                                  'Share your results on social networks!')),
                        ),
                        Padding(
                          
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            width: 350,
                            child: WidgetsToImage(

                              controller: controller,
                              child: SingleChildScrollView(
                                child: SafeArea(
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFBF1A3),
                                        // borderRadius:
                                        //     BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                  style: TextStyle(
                                                    fontFamily: "BakbakOne",
                                                    fontSize: 20,
                                                    // color: Color(0xff2c2c2c),
                                                  ),
                                                  'One Life - Life Tracker'),
                                              Image.asset(
                                                'assets/images/android/icon.png',
                                                width: 50,
                                                height: 50,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('My age:'),
                                              Text(
                                                  style: const TextStyle(
                                                    fontFamily: "BakbakOne",
                                                    fontSize: 30,
                                                    // color: Color(0xff2c2c2c),
                                                  ),
                                                  '$_ageInYears'),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('I lived'),
                                              Text(
                                                  style: const TextStyle(
                                                    fontFamily: "BakbakOne",
                                                    fontSize: 30,
                                                    // color: Color(0xff2c2c2c),
                                                  ),
                                                  '$percentCompleteRounded%'),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('I have'),
                                              Text(
                                                  style: const TextStyle(
                                                    fontFamily: "BakbakOne",
                                                    fontSize: 30,
                                                    // color: Color(0xff2c2c2c),
                                                  ),
                                                  '$percentHaveRounded%'),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('I have years'),
                                              Text(
                                                  style: const TextStyle(
                                                    fontFamily: "BakbakOne",
                                                    fontSize: 30,
                                                    // color: Color(0xff2c2c2c),
                                                  ),
                                                  '$yearsHave'),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          LinearProgressIndicator(
                                            color: const Color(0xff2c2c2c),
                                            backgroundColor:
                                                const Color(0xffB3DDC6),
                                            value: percentComplete,
                                            minHeight: 20,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                '',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              Text(
                                                '*More info in app',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // if (bytes != null) buildImage(bytes!),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Builder(builder: (BuildContext context) {
                            return ElevatedButton(
                              onPressed: () async {
                                final bytes = await controller.capture();
                                setState(() {
                                  this.bytes = bytes;
                                });
                                saveImage(this.bytes);
                                if (context.mounted) {
                                  return toSocialNetworks(context);
                                }
                              },
                              child: const Text(
                                'Share',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }

  // Widget buildImage(Uint8List bytes) => Image.memory(bytes);

  Future<void> sharePressed(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    String message =
        'https://apps.apple.com/app/one-life-life-tracker/id6447756806';
    await Share.share(
      message,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  Future loadImage() async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/image.png');
    if (file.existsSync()) {
      final bytes = await file.readAsBytes();
      setState(() {
        this.bytes = bytes;
      });
    }
  }

  Future saveImage(Uint8List? bytes) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/image.png');
    file.writeAsBytes(bytes!);
  }

  Future toSocialNetworks(context) async {
    final box = context.findRenderObject() as RenderBox?;
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/image.png');
    if (file.existsSync()) {
      await file.readAsBytes();
      await Share.shareFiles(
        ['${appStorage.path}/image.png'],
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }
}
