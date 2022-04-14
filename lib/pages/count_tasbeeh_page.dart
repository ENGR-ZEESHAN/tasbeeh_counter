// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tasbeeh_counter/Models/tasbeeh_data.dart';
import 'package:tasbeeh_counter/database/tasbeeh_db.dart';

import 'package:tasbeeh_counter/utils/themes.dart';
import 'package:tasbeeh_counter/widgets/appbar.dart';

class TasbeehCounter extends StatefulWidget {
  final Tasbeeh tasbeeh;

  const TasbeehCounter({Key? key, required this.tasbeeh}) : super(key: key);
  @override
  State<TasbeehCounter> createState() => _TasbeehCounterState();
}

class _TasbeehCounterState extends State<TasbeehCounter> {
  late int count;
  late int totalCount;
  late String tasbeehName;

  bool isCompleted = false;

  @override
  void initState() {
    count = widget.tasbeeh.currentCount;
    totalCount = widget.tasbeeh.totalCount;
    tasbeehName = widget.tasbeeh.counterName;

    super.initState();
  }

  @override
  void dispose() async {
    updatedb();
    super.dispose();
  }

  Future updatedb() async {
    final finalTasbeeh = Tasbeeh(
        id: widget.tasbeeh.id,
        counterName: tasbeehName,
        currentCount: count,
        totalCount: totalCount,
        timeSnap: DateTime.now().toIso8601String());

    await TasbeehDatabase.instance.updateTasbeeh(finalTasbeeh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyTheme.cream,
        child: SafeArea(
          child: Column(
            children: [
              header(title: 'Tasbeeh', subTitle: 'Counter'),
              counter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget counter() => Expanded(
        child: InkWell(
          onTap: () {
            if (count == totalCount) {
              setState(() {
                isCompleted = true;
              });
            }
            if (count < totalCount) {
              setState(() {
                count++;
              });
            }
          },
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    tasbeehName,
                    style:
                        TextStyle(color: MyTheme.primarySwatch, fontSize: 24),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: counterProgress(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Tap on screen\n to increase counter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyTheme.primaryContrast, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget counterProgress() => Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: MyTheme.primarySwatch,
                strokeWidth: 8.0,
                value: count / totalCount,
              ),
            ),
            isCompleted
                ? Center(
                    child: Icon(
                      Icons.check_rounded,
                      size: 100.0,
                      color: MyTheme.primarySwatch,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$count',
                        style: TextStyle(
                            fontSize: 24.0, color: MyTheme.primaryContrast),
                      ),
                      Container(
                        color: MyTheme.primarySwatch,
                        width: 100,
                        height: 2,
                      ),
                      Text(
                        '$totalCount',
                        style: TextStyle(
                            fontSize: 24.0, color: MyTheme.primaryContrast),
                      ),
                    ],
                  ),
          ],
        ),
      );
}
