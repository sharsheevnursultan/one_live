import 'package:flutter/material.dart';

void main() => runApp(LifeTracker());

class LifeTracker extends StatefulWidget {
  const LifeTracker({super.key});

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

  @override
  Widget build(BuildContext context) {
    MaterialApp(home: LifeTracker());
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
              },
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 52,
                children: squares,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
