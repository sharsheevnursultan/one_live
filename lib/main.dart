import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/in': (context) => const LifeTracker(),
      },
      home: const LifeTracker(),
    );
  }
}

class LifeTracker extends StatefulWidget {
  const LifeTracker({super.key});

  @override
  _LifeTrackerState createState() => _LifeTrackerState();
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      'The One Life app is designed to help you get to know your life better by displaying information about how much time you have already lived, and displaying this data in the form of numbers and tables.'),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/in');
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            )),
          ),
        ));
  }
}

class _LifeTrackerState extends State<LifeTracker> {
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
    double percentComplete = _ageInSeconds / (73 * 365 * 24 * 60 * 60);
    int percentCompleteRounded = (percentComplete * 100).round();


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
        length: 3,
        initialIndex: 0,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('One Life - Life Tracker'),
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
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                SafeArea(
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
                                  fontSize: 40,
                                  color: Colors.blue,
                                ),
                              ),
                              ElevatedButton(
                                // Display a CupertinoDatePicker in date picker mode.
                                onPressed: () => _showDialog(
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
                                ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Your age in:',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.grey[500],
                                ),
                              ),
                              const Text(''),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('years:'),
                              Text('$_ageInYears'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('months:'),
                              Text('$_ageInMonths'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('weeks:'),
                              Text('$_ageInWeeks'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('days:'),
                              Text('$_ageInDays'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('hours:'),
                              Text('$_ageInHours'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('minutes:'),
                              Text('$_ageInMinutes'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('seconds:'),
                              Text('$_ageInSeconds'),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
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
                        ))),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              'According to the WHO, the average life expectancy worldwide is 73 years'),
                          const SizedBox(height: 30),
                          Text(
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
            )));
  }
}
