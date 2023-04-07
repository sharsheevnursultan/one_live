import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(CupertinoApp(home: LifeTracker()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'My Life Weeks',
      home: LifeTracker(),
    );
  }
}

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

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('My Life Weeks'),
      ),
      child: SafeArea(child:
      Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Select your birthdate'),

                onPressed: ()  async {
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
              Text(
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.start,
                  'Your age in weeks: $_ageInWeeks'),
              SizedBox(height: 20),
              Text(
                  style: TextStyle(fontSize: 18.0),
                  'Your age in months: $_ageInMonths'),
              SizedBox(height: 20),
              Text(
                  style: TextStyle(fontSize: 18.0),
                  'Your age in minutes: $_ageInMinutes'),
              SizedBox(height: 20),
              Text(
                  style: TextStyle(fontSize: 18.0),
                  'Your age in seconds: $_ageInSeconds'),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 52,
                  children: squares,
                ),
              ),
              SizedBox(height: 20),
              Text(
                  style: TextStyle(fontSize: 18.0),
                  '$percentCompleteRounded% of average life expectancy'),
              SizedBox(height: 10),
              LinearProgressIndicator(value: percentComplete),
            ],
          ),
        ),
      ), ),
    );
  }
}
