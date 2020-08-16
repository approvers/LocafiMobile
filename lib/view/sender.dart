import 'package:flutter/material.dart';
import 'package:flutter_app/controller/sender.dart';

class SenderPage extends StatefulWidget {
  final ISenderController controller;

  const SenderPage({Key key, this.controller}) : super(key: key);

  @override
  _SenderPageState createState() => _SenderPageState();
}

class _SenderPageState extends State<SenderPage> {
  ISenderController controller;

  _SenderPageState({this.controller});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("ファイル送信"),
      ),
      body: Center(
        // TODO: Create detail component.
        child: Container(),
      ),
    );
  }
}

class _ReceiverSelector extends StatefulWidget {
  final ISenderController controller;

  _ReceiverSelector({this.controller});

  @override
  _ReceiverSelectorState createState() => _ReceiverSelectorState();
}

class _ReceiverSelectorState extends State<_ReceiverSelector> {
  ISenderController controller;
  static const initialValue = "(Please choose one)";
  String selectedValue = initialValue;

  _ReceiverSelectorState({this.controller});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getReceiverNames(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          var cache = snapshot.data;
          cache.insert(0, initialValue);
          return selectorTemplate(cache);
        }
        return selectorTemplate([selectedValue]);
      },
    );
  }

  Widget selectorTemplate(List<String> contents) {
    return DropdownButton(
      value: selectedValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      onChanged: (String newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
      items: contents.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }),
    );
  }
}
