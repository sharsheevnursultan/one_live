import 'dart:io' show Platform;

// Admob Id manager
class AdMobService {
  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      //work id
      return 'ca-app-pub-2550588570628296/9765381559';
      // test id
      // return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      //work ad
      return 'ca-app-pub-2550588570628296/1296225985';
      // test ad
      // return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }
}

// Admob Id manager
class AdMobServiceShare {
  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      //work id
      return 'ca-app-pub-2550588570628296/1606789547';
      // test id
      // return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      //work ad
      return 'ca-app-pub-2550588570628296/2467664823';
      // test ad
      // return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }
}
