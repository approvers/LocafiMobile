import 'dart:io';

import 'package:flutter_app/controller/sender.dart';
import 'package:flutter_app/model/sender.dart';
import 'package:flutter_test/flutter_test.dart';

main() async {
  ISenderModel model = TestingModel();
  ISenderController controller = SenderController(model);
  final serverList = ["Server1", "Server2"];
  await controller.getReceiverNames();
  test(
    "Test for SenderController",
      () async {
        expect(await controller.getReceiverNames(), serverList);
        expect(await controller.onClickSendButton(), false);
      }
  );

 test(
   "Test for after select receiver",
     () async {
        await controller.onSelectReceiver("Server1");
        expect(await controller.onClickSendButton(), true);
     }
 );

 test(
   "Test for invalid url",
     () async {
        expect(await controller.onSelectReceiver("invalid"), NullThrownError);
     }
 );
}

class TestingModel implements ISenderModel {
  List<String> urls;
  @override
  Future<Map<String, String>> getServers() async {
    urls = ["ip1", "ip2"];
    return {"Server1": "ip1", "Server2": "ip2"};
  }

  @override
  Future<String> sendFiles(List<File> file, String url) async {
    for (var element in urls) {
      if (element == url)
        return "200";
    }
    return "404";
  }
}