import 'package:flutter/material.dart';
import '../utils/themes.dart';

Widget header({String title = '', String subTitle = ''}) => Card(
      margin: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: MyTheme.primarySwatch,
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                      height: 0.5,
                      color: MyTheme.primaryContrast,
                      fontSize: 24.0,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_rounded,
                size: 40.0,
                color: MyTheme.primarySwatch,
              ),
            ),
          ],
        ),
      ),
    );
