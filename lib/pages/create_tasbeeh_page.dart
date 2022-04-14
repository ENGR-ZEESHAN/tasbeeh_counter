// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tasbeeh_counter/Models/tasbeeh_data.dart';
import 'package:tasbeeh_counter/database/tasbeeh_db.dart';
import 'package:tasbeeh_counter/pages/count_tasbeeh_page.dart';
import 'package:tasbeeh_counter/widgets/appbar.dart';
import '../utils/themes.dart';

class CreateTasbeeh extends StatelessWidget {
  CreateTasbeeh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyTheme.cream,
        child: SafeArea(
            child: Column(
          children: [
            header(title: 'Create', subTitle: 'Counter'),
            Expanded(child: Center(child: tasbeehForm())),
          ],
        )),
      ),
      floatingActionButton: fab(context),
    );
  }

  final nameController = TextEditingController();
  final countController = TextEditingController();

  Widget tasbeehForm() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Counter Name',
                  hintText: 'Kalma',
                  labelStyle: TextStyle(color: MyTheme.primarySwatch),
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(color: MyTheme.primarySwatch),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: countController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Count Limit',
                  hintText: '1000',
                  labelStyle: TextStyle(color: MyTheme.primarySwatch),
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(color: MyTheme.primarySwatch),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget fab(BuildContext context) => Container(
        width: 100.0,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: MyTheme.primarySwatch,
        ),
        child: InkWell(
          onTap: () async {
            Tasbeeh _tasbeeh;
            _tasbeeh = Tasbeeh(
                counterName: nameController.text,
                currentCount: 0,
                totalCount: int.parse(countController.text),
                timeSnap: DateTime.now().toIso8601String());

            final result =
                await TasbeehDatabase.instance.createTasbeeh(_tasbeeh);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => TasbeehCounter(
                  tasbeeh: result,
                ),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 35.0,
            color: Colors.white,
          ),
        ),
      );
}
