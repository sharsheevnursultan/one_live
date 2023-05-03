
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class MainDatePicker extends StatefulWidget {
//   const MainDatePicker({Key? key}) : super(key: key);
//   void _updateAgeInOtherUnits(DateTime birthdate) {
//     Duration age = DateTime.now().difference(birthdate);
//     int ageInYears = age.inDays ~/ 365;
//     int ageInMonths = age.inDays ~/ 30;
//     int ageInWeeks = (age.inDays / 7).floor();
//     int ageInDays = age.inDays;
//     int ageInHours = age.inHours;
//     int ageInMinutes = age.inMinutes;
//     int ageInSeconds = age.inSeconds;
//     setState(() {
//       myAgeInYears = ageInYears;
//       myAgeInMonths = ageInMonths;
//       myAgeInWeeks = ageInWeeks;
//       myAgeInDays = ageInDays;
//       myAgeInHours = ageInHours;
//       myAgeInMinutes = ageInMinutes;
//       myAgeInSeconds = ageInSeconds;
//     });
//     notifyListeners();
//   };
//
//   @override
//   State<MainDatePicker> createState() => _MainDatePickerState();
// }
//
// class _MainDatePickerState extends State<MainDatePicker> {
//   @override
//   Widget build(BuildContext context) {
//     void showDialog(Widget child) {
//       showCupertinoModalPopup<void>(
//           context: context,
//           builder: (BuildContext context) => Container(
//             height: 216,
//             padding: const EdgeInsets.only(top: 6.0),
//             // The Bottom margin is provided to align the popup above the system
//             // navigation bar.
//             margin: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             // Provide a background color for the popup.
//             color: CupertinoColors.systemBackground.resolveFrom(context),
//             // Use a SafeArea widget to avoid system overlaps.
//             child: SafeArea(
//               top: false,
//               child: child,
//             ),
//           ));
//     }
//     return SingleChildScrollView(
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                     'Select your birthday to find out your life data'),
//                 const SizedBox(height: 30),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '${date.month}.${date.day}.${date.year}',
//                       style: const TextStyle(
//                         fontFamily: "BakbakOne",
//                         fontSize: 40,
//                         color: Color(0xff2c2c2c),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         showDialog(
//                           CupertinoDatePicker(
//                             initialDateTime: date,
//                             mode: CupertinoDatePickerMode.date,
//                             use24hFormat: true,
//                             minimumYear: 1900,
//                             // This is called when the user changes the date.
//                             onDateTimeChanged: (DateTime newDate) {
//                               date = newDate;
//                               _updateAgeInOtherUnits(date);
//                             },
//                           ),
//                         );
//                         showInterstitialAd();
//                       },
//                       // Display a CupertinoDatePicker in date picker mode.
//
//                       // In this example, the date is formatted manually. You can
//                       // use the intl package to format the value based on the
//                       // user's locale settings.
//                       child: const Text(
//                         "Enter date",
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 30),
//                 Container(
//                   padding: const EdgeInsets.all(16.0),
//                   decoration: const BoxDecoration(
//                     color: Color(0xffFBF1A3),
//                     borderRadius:
//                     BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text(
//                             'Your age in:',
//                             style: TextStyle(
//                               fontFamily: "BakbakOne",
//                               fontSize: 40,
//                               // color: Color(0xff2c2c2c),
//                             ),
//                           ),
//                           Text(''),
//                         ],
//                       ),
//                       const SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('years:'),
//                           Text('$myAgeInYears'),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('months:'),
//                           Text('$myAgeInMonths'),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('weeks:'),
//                           Text('$myAgeInWeeks'),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('days:'),
//                           Text('$myAgeInDays'),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('hours:'),
//                           Text('$myAgeInHours'),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('minutes:'),
//                           Text('$myAgeInMinutes'),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('seconds:'),
//                           Text('$myAgeInSeconds'),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//                 // ElevatedButton(onPressed: initialIndexController, child: Text('Next Tab')),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
