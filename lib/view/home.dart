
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/controller/home.dart';

class HomePage extends StatelessWidget {
  final IHomeController controller;
  HomePage({this.controller});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Locafi Mobile"),
            Row(
              children: [
                RaisedButton(
                  child: Text("Send"),
                  onPressed: () =>
                      // Navigator.of(context).pushNamed(controller.GetSendPage()),
                      log(controller.GetSendPage()),
                ),
                RaisedButton(
                  child: Text("Receive"),
                  onPressed: () =>
                      // Navigator.of(context).pushNamed(controller.GetReceivePage()),
                      log(controller.GetReceivePage()),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}