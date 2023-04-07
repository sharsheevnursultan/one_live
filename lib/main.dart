import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LifeTracker()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LifeTracker(),
    );
  }
}

class LifeTracker extends StatefulWidget {
  const LifeTracker({super.key});

  @override
  _LifeTrackerState createState() => _LifeTrackerState();
}

class _LifeTrackerState extends State<LifeTracker> {
  final int _averageLifeExpectancyInMonths = 1200; // 100 years in months

  void _updateAgeInOtherUnits(DateTime birthdate) {
    Duration age = DateTime.now().difference(birthdate);
    int ageInMonths = age.inDays ~/ 30;
    int ageInWeeks = (age.inDays / 7).floor();
    int ageInDays = age.inDays;
    int ageInMinutes = age.inMinutes;
    int ageInSeconds = age.inSeconds;
    setState(() {
      _ageInMonths = ageInMonths;
      _ageInWeeks = ageInWeeks;
      _ageInDays = ageInDays;
      _ageInMinutes = ageInMinutes;
      _ageInSeconds = ageInSeconds;
    });
  }

  int _ageInMonths = 0;
  int _ageInWeeks = 0;
  int _ageInDays = 0;
  int _ageInMinutes = 0;
  int _ageInSeconds = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> squares = [];
    for (int i = 0; i < _averageLifeExpectancyInMonths; i++) {
      Color? color = Colors.grey[200];
      if (i < _ageInMonths) {
        color = Colors.blue;
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
    double percentComplete = _ageInSeconds / (80 * 365 * 24 * 60 * 60);
    int percentCompleteRounded = (percentComplete * 100).round();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Life Tracker'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Select your birthdate'),
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                    context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    _updateAgeInOtherUnits(selectedDate!);
                  },
                ),
                const SizedBox(height: 20),
                Text(
                    style: const TextStyle(fontSize: 18.0),
                    'Your age in months: $_ageInMonths'),
                const SizedBox(height: 20),
                Text(
                    style: const TextStyle(fontSize: 18.0),
                    'Your age in weeks: $_ageInWeeks'),
                const SizedBox(height: 20),
                Text(
                    style: const TextStyle(fontSize: 18.0),
                    'Your age in days: $_ageInDays'),
                const SizedBox(height: 20),
                Text(
                    style: const TextStyle(fontSize: 18.0),
                    'Your age in minutes: $_ageInMinutes'),
                const SizedBox(height: 20),
                Text(
                    style: const TextStyle(fontSize: 18.0),
                    'Your age in seconds: $_ageInSeconds'),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 24,
                    children: squares,
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                  style: const TextStyle(fontSize: 18.0),
                  '$percentCompleteRounded% of average life expectancy'),
              const SizedBox(height: 10),
              LinearProgressIndicator(value: percentComplete),
            ],
          ),
        ),
      ), ),
    );
  }
}
