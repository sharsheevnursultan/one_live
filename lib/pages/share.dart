import 'dart:io' show File;
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../main.dart';
import 'admob_service.dart';

class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  late InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

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
        adUnitId: AdMobServiceShare.interstitialAdUnitId!,
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

  // WidgetsToImageController to access widget
  WidgetsToImageController controller = WidgetsToImageController();

  // to save image bytes of widget
  Uint8List? bytes;

  get ageInYears => Provider.of<MyData>(context).myAgeInYears;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    final myAgeInSeconds = Provider.of<MyData>(context).myAgeInSeconds;
    double percentComplete = myAgeInSeconds / (73 * 365 * 24 * 60 * 60);
    int percentCompleteRounded = (percentComplete * 100).round();
    int percentHaveRounded = (percentCompleteRounded - 100).abs().round();
    num yearsHave =
        Provider.of<LifeTrackerState>(context).averageLifeExpectancyInMonths ~/
                12 -
            ageInYears.toInt();

    return Container(
      color: const Color(0xfffaf7ed),
      child: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Text('Share your results on social networks!')),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                        '$ageInYears'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('I lived:'),
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
                                    const Text('I have:'),
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
                                    const Text('I have years:'),
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
                                  backgroundColor: const Color(0xffB3DDC6),
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
                // if (bytes != null) buildImage(bytes!),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Builder(builder: (BuildContext context) {
                    return CupertinoButton.filled(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      onPressed: () async {
                        showInterstitialAd();
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
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('share dispose');
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
