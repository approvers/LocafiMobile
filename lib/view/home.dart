
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locafi_mobile/controller/home.dart';

class HomePage extends StatelessWidget {
  final IHomeController controller;
  HomePage({this.controller});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Locafi Mobile",
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RaisedButton(
                  child: Text("Send"),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(controller.getSendPage()),
                ),
                RaisedButton(
                  child: Text("Receive"),
                  onPressed: () =>
                      // Navigator.of(context).pushNamed(controller.GetReceivePage()),
                      log(controller.getReceivePage()),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}