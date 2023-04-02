// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//
// void main() => runApp(MaterialApp(home: LifeTracker()));
//
// class LifeTracker extends StatefulWidget {
//   const LifeTracker({super.key});
//
//   @override
//   _LifeTrackerState createState() => _LifeTrackerState();
// }
//
// class _LifeTrackerState extends State<LifeTracker> {
//   int _ageInWeeks = 0;
//   int _ageInMonths = 0;
//   final int _averageLifeExpectancyInWeeks = 4160; // 80 years in weeks
//   final int _averageLifeExpectancyInMonths = 960; // 80 years in months
//
//   void _updateAgeInWeeks(DateTime birthdate) {
//     Duration age = DateTime.now().difference(birthdate);
//     int ageInWeeks = (age.inDays / 7).floor();
//     int ageInMonths = (age.inDays / 7).floor();
//
//     setState(() {
//       _ageInWeeks = ageInWeeks;
//       _ageInMonths = ageInMonths;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> squares = [];
//     for (int i = 0; i < _averageLifeExpectancyInWeeks; i++) {
//       Color? color = Colors.grey[200];
//       if (i < _ageInWeeks) {
//         color = Colors.blue;
//       }
//       squares.add(
//         Container(
//           width: 10,
//           height: 10,
//           margin: const EdgeInsets.all(1),
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(1),
//           ),
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Life Tracker'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () async {
//                   DateTime? selectedDate = await DatePicker.showDatePicker(
//                       context,
//                       showTitleActions: true,
//                       minTime: DateTime(1900),
//                       maxTime: DateTime.now(), onChanged: (date) {
//                     print('change $date');
//                   }, onConfirm: (date) {
//                     print('confirm $date');
//                   }, currentTime: DateTime.now(), locale: LocaleType.en);
//                   _updateAgeInWeeks(selectedDate!);
//                 },
//                 child: const Text(
//                   'Select your birthdate',
//                 )),
//             Expanded(
//               child: GridView.count(
//                 scrollDirection: Axis.horizontal,
//                 crossAxisCount: 52,
//                 children: squares,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: LifeTracker()));

class LifeTracker extends StatefulWidget {
  @override
  _LifeTrackerState createState() => _LifeTrackerState();
}

class _LifeTrackerState extends State<LifeTracker> {
  int _ageInWeeks = 0;
  int _averageLifeExpectancyInWeeks = 4160; // 80 years in weeks

  void _updateAgeInWeeks(DateTime birthdate) {
    Duration age = DateTime.now().difference(birthdate);
    int ageInWeeks = (age.inDays / 7).floor();
    setState(() {
      _ageInWeeks = ageInWeeks;
    });
  }

  void _updateAgeInOtherUnits(DateTime birthdate) {
    Duration age = DateTime.now().difference(birthdate);
    int ageInMonths = age.inDays ~/ 30;
    int ageInMinutes = age.inMinutes;
    int ageInSeconds = age.inSeconds;
    setState(() {
      _ageInMonths = ageInMonths;
      _ageInMinutes = ageInMinutes;
      _ageInSeconds = ageInSeconds;
    });
  }

  int _ageInMonths = 0;
  int _ageInMinutes = 0;
  int _ageInSeconds = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> squares = [];
    for (int i = 0; i < _averageLifeExpectancyInWeeks; i++) {
      Color? color = Colors.grey[200];
      if (i < _ageInWeeks) {
        color = Colors.blue;
      }
      squares.add(
        Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
    }

    double percentComplete = _ageInSeconds / (80 * 365 * 24 * 60 * 60);
    int percentCompleteRounded = (percentComplete * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: Text('Life Tracker'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Select your birthdate'),
              onPressed: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                _updateAgeInWeeks(selectedDate!);
                _updateAgeInOtherUnits(selectedDate);
              },
            ),
            SizedBox(height: 20),
            Text('Age in weeks: $_ageInWeeks'),
            SizedBox(height: 20),
            Text('Age in months: $_ageInMonths'),
            SizedBox(height: 20),
            Text('Age in minutes: $_ageInMinutes'),
            SizedBox(height: 20),
            Text('Age in seconds: $_ageInSeconds'),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 52,
                children: squares,
              ),
            ),
            SizedBox(height: 20),
            Text('$percentCompleteRounded% of average life expectancy'),
            SizedBox(height: 10),
            LinearProgressIndicator(value: percentComplete),
          ],
        ),
      ),
    );
  }
}
