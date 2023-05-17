// import 'dart:async';
//
// import 'package:in_app_purchase/in_app_purchase.dart';
//
// class InAppPurchaseService {
//   final InAppPurchase _inAppPurchase = InAppPurchase.instance;
//   final Stream<List<PurchaseDetails>> _storeSubscription =
//       InAppPurchase.instance.purchaseStream;
//
//   InAppPurchase get instance => _inAppPurchase;
// }
//
// static const Set<String> coins = {
//   '70_coins',
//   '350_coins',
//   '700_coins',
//   '1400_coins',
//   '3500_coins',
//   '7000_coins',
//   '17500_coins',
// };
//
// Future<List<ProductDetails>> getProductsByType(StoreItemType type) async {
//   final Set<String> productsIds;
//
//   switch (type) {
//     case StoreItemType.coins:
//       productsIds = StoreProductsIds.coins;
//       break;
//     case StoreItemType.subscription:
//       productsIds = StoreProductsIds.subscriptions;
//       break;
//   }
//
//   final bool isAvailable = await _inAppPurchase.isAvailable();
//   if (!isAvailable) {
//     return [];
//   }
//
//   final ProductDetailsResponse productDetailResponse =
//   await _inAppPurchase.queryProductDetails(productsIds);
//
//   if (productDetailResponse.error != null ||
//       productDetailResponse.productDetails.isEmpty) {
//     return [];
//   }
//
//   return productDetailResponse.productDetails;
// }
//
// class ProductDetails {
//   /// Creates a new product details object with the provided details.
//   ProductDetails({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.rawPrice,
//     required this.currencyCode,
//     this.currencySymbol = '',
//   });
//
//   /// The identifier of the product.
//   ///
//   /// For example, on iOS it is specified in App Store Connect; on Android, it is specified in Google Play Console.
//   final String id;
//
//   /// The title of the product.
//   ///
//   /// For example, on iOS it is specified in App Store Connect; on Android, it is specified in Google Play Console.
//   final String title;
//
//   /// The description of the product.
//   ///
//   /// For example, on iOS it is specified in App Store Connect; on Android, it is specified in Google Play Console.
//   final String description;
//
//   /// The price of the product, formatted with currency symbol ("$0.99").
//   ///
//   /// For example, on iOS it is specified in App Store Connect; on Android, it is specified in Google Play Console.
//   final String price;
//
//   /// The unformatted price of the product, specified in the App Store Connect or Sku in Google Play console based on the platform.
//   /// The currency unit for this value can be found in the [currencyCode] property.
//   /// The value always describes full units of the currency. (e.g. 2.45 in the case of $2.45)
//   final double rawPrice;
//
//   /// The currency code for the price of the product.
//   /// Based on the price specified in the App Store Connect or Sku in Google Play console based on the platform.
//   final String currencyCode;
//
//   /// The currency symbol for the locale, e.g. $ for US locale.
//   ///
//   /// When the currency symbol cannot be determined, the ISO 4217 currency code is returned.
//   final String currencySymbol;
// }
//
// class PurchaseDetailsStreamSubscription {
//   final InAppPurchaseService inAppPurchaseService = Get.find<
//       InAppPurchaseService>();
//   final Function()? onPending;
//   final Function(PurchaseDetails purchaseDetails)? onPurchased;
//   final Function()? onError;
//   final Function()? onRestored;
//   final Function()? onCanceled;
//
//   StreamSubscription<List<PurchaseDetails>>? _streamSubscription;
//
//   PurchaseDetailsStreamSubscription({
//     this.onPending,
//     this.onPurchased,
//     this.onError,
//     this.onRestored,
//     this.onCanceled,
//   });
//
//   Future<void> init() async {
//     _streamSubscription = inAppPurchaseService.getStoreSubscription().listen(
//           (List<PurchaseDetails> events) {
//         Future.forEach(
//           events,
//               (PurchaseDetails purchaseDetails) async {
//             if (purchaseDetails.pendingCompletePurchase) {
//               await inAppPurchaseService.completePurchase(purchaseDetails);
//             }
//             switch (purchaseDetails.status) {
//               case PurchaseStatus.pending:
//                 onPending?.call();
//                 break;
//               case PurchaseStatus.purchased:
//                 onPurchased?.call(purchaseDetails);
//                 break;
//               case PurchaseStatus.error:
//                 onError?.call();
//                 break;
//               case PurchaseStatus.restored:
//                 onRestored?.call();
//                 break;
//               case PurchaseStatus.canceled:
//                 onCanceled?.call();
//                 break;
//             }
//           },
//         );
//       },
//     );
//   }
//
//   void close() {
//     _streamSubscription?.cancel();
//   }
// }
//
// Future<bool> buyItemInStore(ProductDetails product) async {
//   final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
//   return InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
// }
//
// Future<void> completePurchase(PurchaseDetails purchaseDetails) async {
//   await InAppPurchase.instance.completePurchase(purchaseDetails);
// }
// purchaseDetailsStreamSubscription = PurchaseDetailsStreamSubscription
// (
// onCanceled: closeLoader,
// onError: closeLoader,
// onPurchased: (PurchaseDetails purchaseDetails) async {
// closeLoader();
// try {
// // тут мы проверяем наш платеж на стороне сервера передав данные о платеже ,
// // и если все ок завершаем  покупку
// final bool res = await transactionRepository
//     .createTransaction(purchaseDetails.verificationData.serverVerificationData);
// if (res) {
// await inAppPurchaseService.completePurchase(purchaseDetails);
// await updateBalance();
// }
// } catch (_, __) {}
// },
// )
// ..
// init
// (
// );