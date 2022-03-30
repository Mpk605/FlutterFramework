import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercice 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Exercice 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _birthday = DateTime.now();
  DateTime _firstDate = DateTime.now();
  DateTime _secondDate = DateTime.now();

  Map<String, String> _age = {
    'year': '00',
    'month': '00',
    'day': '00',
    'hour': '00',
    'minute': '00',
    'second': '00'
  };

  Map<String, String> _dateDifference = {
    'year': '00',
    'month': '00',
    'day': '00'
  };

  Timer? _ageTimer;

  /// Returns a Map<String, String> containing the difference between date1 and date2
  Map<String, String> _differenceBetweenDates(DateTime date1, DateTime date2) {
    Map<String, String> difference = {};

    difference['year'] = (date1.year - date2.year).toString().padLeft(2, '0');
    difference['month'] =
        (date1.month - date2.month).abs().toString().padLeft(2, '0');
    difference['day'] =
        (date1.day - date2.day).abs().toString().padLeft(2, '0');
    difference['hour'] =
        (date1.hour - date2.hour).abs().toString().padLeft(2, '0');
    difference['minute'] =
        (date1.minute - date2.minute).abs().toString().padLeft(2, '0');
    difference['second'] =
        (date1.second - date2.second).abs().toString().padLeft(2, '0');

    return difference;
  }

  /// Stores the difference between _birthday and DateTime.now() into the dictionary _age every second
  void _calculateAge(DateTime _date) {
    if (_ageTimer != null && _ageTimer!.isActive) _ageTimer!.cancel();
    _ageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _age = _differenceBetweenDates(DateTime.now(), _date);
      });
    });
  }

  /// Displays the date picker, and update the correct date
  Future<void> _selectDate(int date) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: (date == 0)
          ? _birthday
          : (date == 1)
              ? _firstDate
              : _secondDate,
      firstDate: DateTime(0, 1),
      lastDate: DateTime.now(),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        if (date == 0) {
          _birthday = newDate;
          _calculateAge(_birthday);
        } else if (date == 1) {
          _firstDate = newDate;
          _dateDifference = _differenceBetweenDates(_firstDate, _secondDate);
        } else {
          _secondDate = newDate;
          _dateDifference = _differenceBetweenDates(_firstDate, _secondDate);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff5808e5),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Age'),
              Tab(text: 'Différence'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Date de naissance : '),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton.icon(
                        onPressed: () => _selectDate(0),
                        icon: const Icon(Icons.date_range_outlined),
                        label: Text(
                          _birthday.day.toString().padLeft(2, '0') +
                              '/' +
                              _birthday.month.toString().padLeft(2, '0') +
                              '/' +
                              _birthday.year.toString().padLeft(4, '0'),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Tu as ',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: const Color(0xffdfebf9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _age['year'] ?? '00',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                            const Text(
                              ' an(s)',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 52.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: const Color(0xffdfebf9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _age['month'] ?? '00',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                            const Text(
                              ' mois',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 65.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: const Color(0xffdfebf9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _age['day'] ?? '00',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                            const Text(
                              ' jour(s)',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 81.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: const Color(0xffdfebf9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _age['hour'] ?? '00',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                            const Text(
                              ' heure(s)',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 93.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: const Color(0xffdfebf9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _age['minute'] ?? '00',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                            const Text(
                              ' minute(s)',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, right: 16.0, left: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 106.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: const Color(0xffdfebf9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _age['second'] ?? '00',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                            const Text(
                              ' seconde(s)',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Date 1 : '),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton.icon(
                        onPressed: () => _selectDate(1),
                        icon: const Icon(Icons.date_range_outlined),
                        label: Text(
                          _firstDate.day.toString().padLeft(2, '0') +
                              '/' +
                              _firstDate.month.toString().padLeft(2, '0') +
                              '/' +
                              _firstDate.year.toString().padLeft(4, '0'),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Date 2 : '),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton.icon(
                        onPressed: () => _selectDate(2),
                        icon: const Icon(Icons.date_range_outlined),
                        label: Text(
                          _secondDate.day.toString().padLeft(2, '0') +
                              '/' +
                              _secondDate.month.toString().padLeft(2, '0') +
                              '/' +
                              _secondDate.year.toString().padLeft(4, '0'),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                        child: Text(
                          'La différence entre \nles 2 dates est de : ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 3.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: const Color(0xffdfebf9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _dateDifference['year'] ?? '00',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                            const Text(
                              ' an(s)',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: const Color(0xffdfebf9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _dateDifference['month'] ?? '00',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                            const Text(
                              ' mois',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, right: 16.0, left: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 14.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: const Color(0xffdfebf9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _dateDifference['day'] ?? '00',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                            const Text(
                              ' jour(s)',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
