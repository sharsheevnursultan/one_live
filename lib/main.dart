import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CupertinoApp(home: LifeTracker()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
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
  final List<Widget> _tabs = [
    const MetricsTab(),
    const SquaresTab(), // see the HomeTab class below
    const PercentsTab() // see the SettingsTab class below
  ];

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

    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.time),
                label: 'Metrics',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_grid_2x2),
                label: 'Blocks',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.percent),
                label: 'Percent',
              ),
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return _tabs[index];
          },
        ));
  }
}

class MetricsTab extends StatelessWidget {
  const MetricsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return Center(
          child: TabBarView(
            children: <Widget>[
              SafeArea(
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SquaresTab extends StatelessWidget {
  const SquaresTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return Center(
          child: TabBarView(
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 36,
                            children: squares,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PercentsTab extends StatelessWidget {
  const PercentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return Center(
          child: TabBarView(
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            style: const TextStyle(fontSize: 18.0),
                            '$percentCompleteRounded% of average life expectancy'),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: percentComplete,
                          minHeight: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
